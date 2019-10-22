Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC1E0B9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfJVSl7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 14:41:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15076 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbfJVSl7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 14:41:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5daf4d7b0000>; Tue, 22 Oct 2019 11:42:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Oct 2019 11:41:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 Oct 2019 11:41:58 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Oct
 2019 18:41:57 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Oct
 2019 18:41:57 +0000
Subject: Re: [PATCH 1/1] mm/gup_benchmark: fix MAP_HUGETLB case
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
References: <20191021212435.398153-1-jhubbard@nvidia.com>
 <20191021212435.398153-2-jhubbard@nvidia.com>
 <20191022171452.GA5169@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1095fd94-1c0b-de61-7ceb-c963e29575b6@nvidia.com>
Date:   Tue, 22 Oct 2019 11:41:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022171452.GA5169@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571769723; bh=JT3F3dTTKjKzOGM9MyYbERGszfW34mcd8Au3SboJObQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lC/Nm3hCblA57K9jdrp7xEdECWAxkYwE4XhvI2g6acMV/up4ev7q990mcF1lsaBwU
         a/TEspy2QuvvK46Z/mk6KPGqX3iLVCJEqmS6EHRYABuh7xrDk3SVLTW81KTKwIr+5m
         IlbaJVPUVXF9v5RRjC5FLo3z9N5/9PxNqeIwDnfx4VYvrp2yBmI2CqYJV08yIHXMcv
         CKc6fPj8c25YM9KbpMGmWOulWkJQ1AEsS1RDZEKOVEFNrhhemvH6m2srdZYPEZSVG9
         QEmcVj8k/U5mQX5wJZQMkLOh59wMVmryjHdSlSCN4on+pCxTNEUyrV/9PmQKROHIMk
         8QHNdDn0gRkZw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/22/19 10:14 AM, Jerome Glisse wrote:
> On Mon, Oct 21, 2019 at 02:24:35PM -0700, John Hubbard wrote:
>> The MAP_HUGETLB ("-H" option) of gup_benchmark fails:
>>
>> $ sudo ./gup_benchmark -H
>> mmap: Invalid argument
>>
>> This is because gup_benchmark.c is passing in a file descriptor to
>> mmap(), but the fd came from opening up the /dev/zero file. This
>> confuses the mmap syscall implementation, which thinks that, if the
>> caller did not specify MAP_ANONYMOUS, then the file must be a huge
>> page file. So it attempts to verify that the file really is a huge
>> page file, as you can see here:
>>
>> ksys_mmap_pgoff()
>> {
>>     if (!(flags & MAP_ANONYMOUS)) {
>>         retval = -EINVAL;
>>         if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
>>             goto out_fput; /* THIS IS WHERE WE END UP */
>>
>>     else if (flags & MAP_HUGETLB) {
>>         ...proceed normally, /dev/zero is ok here...
>>
>> ...and of course is_file_hugepages() returns "false" for the /dev/zero
>> file.
>>
>> The problem is that the user space program, gup_benchmark.c, really just
>> wants anonymous memory here. The simplest way to get that is to pass
>> MAP_ANONYMOUS whenever MAP_HUGETLB is specified, so that's what this
>> patch does.
> 
> This looks wrong, MAP_HUGETLB should only be use to create vma
> for hugetlbfs. If you want anonymous private vma do not set the
> MAP_HUGETLB. If you want huge page inside your anonymous vma
> there is nothing to do at the mmap time, this is the job of the
> transparent huge page code (THP).
> 

Not the point. Please look more closely at ksys_mmap_pgoff(). You'll 
see that, since 2009 (and probably earlier; 2009 is just when Hugh Dickens 
moved it over from util.c), this routine has had full support for using
hugetlbfs automatically, via mmap.

It does that via hugetlb_file_setup():

unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
			      unsigned long prot, unsigned long flags,
			      unsigned long fd, unsigned long pgoff)
{
...
	if (!(flags & MAP_ANONYMOUS)) {
...
	} else if (flags & MAP_HUGETLB) {
		struct user_struct *user = NULL;
		struct hstate *hs;

		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
		if (!hs)
			return -EINVAL;

		len = ALIGN(len, huge_page_size(hs));
		/*
		 * VM_NORESERVE is used because the reservations will be
		 * taken when vm_ops->mmap() is called
		 * A dummy user value is used because we are not locking
		 * memory so no accounting is necessary
		 */
		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len,
				VM_NORESERVE,
				&user, HUGETLB_ANONHUGE_INODE,
				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
		if (IS_ERR(file))
			return PTR_ERR(file);
	}
...


Also, there are 14 (!) other pre-existing examples of passing
MAP_HUGETLB | MAP_ANONYMOUS to mmap, so I'm not exactly the first one
to reach this understanding.


> NAK as misleading

Ouch. But I think I'm actually leading correctly, rather than misleading.
Can you prove me wrong? :)


thanks,

John Hubbard
NVIDIA
