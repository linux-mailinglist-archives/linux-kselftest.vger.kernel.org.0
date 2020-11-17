Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66672B7103
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 22:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKQViw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 16:38:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQViv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 16:38:51 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C093221F9;
        Tue, 17 Nov 2020 21:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605649131;
        bh=4EQ+dSvnoPSG/5zOUmQnMxe4qQZrdgQ5y2+5szjbJJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuU3kTJmWloxSxZogLHlf/225VsPNmnG82ex9NOm9XWPsx/aFltg4zaDkIvxdcLH6
         2eDrQGkbY+FcsRzz25cd4FSmfBzkNXCH9ZZmxf7po2FDuUP3XMlmw9geSioMsgmJTV
         RaWQDhtCkstkFCJ57EGQqGuD+fL2AaN+eyz0F68M=
Date:   Tue, 17 Nov 2020 23:38:41 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v41 20/24] selftests/x86: Add a selftest for SGX
Message-ID: <20201117213841.GB14833@kernel.org>
References: <20201112220135.165028-1-jarkko@kernel.org>
 <20201112220135.165028-21-jarkko@kernel.org>
 <20201117172650.GI5719@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117172650.GI5719@zn.tnic>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 17, 2020 at 06:26:50PM +0100, Borislav Petkov wrote:
> On Fri, Nov 13, 2020 at 12:01:31AM +0200, Jarkko Sakkinen wrote:
> > +bool encl_load(const char *path, struct encl *encl)
> > +{
> > +	Elf64_Phdr *phdr_tbl;
> > +	off_t src_offset;
> > +	Elf64_Ehdr *ehdr;
> > +	int i, j;
> > +	int ret;
> > +
> > +	memset(encl, 0, sizeof(*encl));
> > +
> > +	ret = open("/dev/sgx_enclave", O_RDWR);
> > +	if (ret < 0) {
> > +		fprintf(stderr, "Unable to open /dev/sgx_enclave\n");
> > +		goto err;
> > +	}
> > +
> > +	encl->fd = ret;
> > +
> > +	if (!encl_map_bin(path, encl))
> > +		goto err;
> > +
> > +	ehdr = encl->bin;
> > +	phdr_tbl = encl->bin + ehdr->e_phoff;
> > +
> > +	for (i = 0; i < ehdr->e_phnum; i++) {
> > +		Elf64_Phdr *phdr = &phdr_tbl[i];
> > +
> > +		if (phdr->p_type == PT_LOAD)
> > +			encl->nr_segments++;
> > +	}
> > +
> > +	encl->segment_tbl = calloc(encl->nr_segments,
> > +				   sizeof(struct encl_segment));
> > +	if (!encl->segment_tbl)
> > +		goto err;
> > +
> > +	for (i = 0, j = 0; i < ehdr->e_phnum; i++) {
> > +		Elf64_Phdr *phdr = &phdr_tbl[i];
> > +		unsigned int flags = phdr->p_flags;
> > +		struct encl_segment *seg;
> > +
> > +		if (phdr->p_type != PT_LOAD)
> > +			continue;
> > +
> > +		seg = &encl->segment_tbl[j];
> > +
> > +		if (!!(flags & ~(PF_R | PF_W | PF_X))) {
> > +			fprintf(stderr,
> > +				"%d has invalid segment flags 0x%02x.\n", i,
> > +				phdr->p_flags);
> > +			goto err;
> > +		}
> > +
> > +		if (j == 0 && flags != (PF_R | PF_W)) {
> > +			fprintf(stderr,
> > +				"TCS has invalid segment flags 0x%02x.\n",
> > +				phdr->p_flags);
> > +			goto err;
> > +		}
> > +
> > +		if (j == 0) {
> > +			src_offset = (phdr->p_offset & PAGE_MASK) - src_offset;
> > +
> > +			seg->prot = PROT_READ | PROT_WRITE;
> > +			seg->flags = SGX_PAGE_TYPE_TCS << 8;
> > +		} else  {
> > +			seg->prot = (phdr->p_flags & PF_R) ? PROT_READ : 0;
> > +			seg->prot |= (phdr->p_flags & PF_W) ? PROT_WRITE : 0;
> > +			seg->prot |= (phdr->p_flags & PF_X) ? PROT_EXEC : 0;
> > +			seg->flags = (SGX_PAGE_TYPE_REG << 8) | seg->prot;
> > +		}
> > +
> > +		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
> > +		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
> > +
> > +		printf("0x%016lx 0x%016lx 0x%02x\n", seg->offset, seg->size,
> > +		       seg->prot);
> > +
> > +		j++;
> > +	}
> > +
> > +	assert(j == encl->nr_segments);
> > +
> > +	encl->src = encl->bin + src_offset;
> > +	encl->src_size = encl->segment_tbl[j - 1].offset +
> > +			 encl->segment_tbl[j - 1].size;
> > +
> > +	for (encl->encl_size = 4096; encl->encl_size < encl->src_size; )
> > +		encl->encl_size <<= 1;
> 
> Something's fishy. That selftest fails with
> 
> mmap: Cannot allocate memory
> 
> I sprinkled some printfs at this size computation above and here's what
> it says:
> 
> 0x00007fdd3b4ca190 0x0000000000002000 0x03
> 0x00007fdd3b4cc190 0x0000000000001000 0x05
> 0x00007fdd3b4cd190 0x0000000000003000 0x03
> encl_load: encl->nr_segments: 3
> encl_load: seg2 offset: 0x7fdd3b4cd190, seg2 size: 12288
> encl_load: encl_size: 140737488355328, src_size: 140588159402384
> encl_map_area: encl_size: 140737488355328
> mmap: Cannot allocate memory

In my machine, with the current version:

➜  sgx (master) ✗ ./test_sgx
0x0000000000000000 0x0000000000002000 0x03
0x0000000000002000 0x0000000000001000 0x05
0x0000000000003000 0x0000000000003000 0x03
SUCCESS

This the bug, src_offset initialization:

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 07988de6b767..9d43b75aaa55 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -185,7 +185,7 @@ bool encl_load(const char *path, struct encl *encl)
                }
 
                if (j == 0) {
-                       src_offset = (phdr->p_offset & PAGE_MASK) - src_offset;
+                       src_offset = phdr->p_offset & PAGE_MASK;
 
                        seg->prot = PROT_READ | PROT_WRITE;
                        seg->flags = SGX_PAGE_TYPE_TCS << 8;

This was introduced when moving from converting elf to bin to load
directly from elf. In my case 'src_offset' happened to be zero and
I have not thus noticed this before.

/Jarkko
