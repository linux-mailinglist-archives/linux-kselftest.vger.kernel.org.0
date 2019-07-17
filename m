Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C936BB17
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2019 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfGQLJe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jul 2019 07:09:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbfGQLJe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jul 2019 07:09:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HB6DLo144968
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2019 07:09:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tsytgfuwq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2019 07:09:32 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 17 Jul 2019 12:09:29 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Jul 2019 12:09:19 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6HB9I7C39190742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 11:09:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C29152063;
        Wed, 17 Jul 2019 11:09:18 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.168])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 366B052050;
        Wed, 17 Jul 2019 11:09:15 +0000 (GMT)
Date:   Wed, 17 Jul 2019 14:09:13 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v18 08/15] userfaultfd: untag user pointers
References: <cover.1561386715.git.andreyknvl@google.com>
 <d8e3b9a819e98d6527e506027b173b128a148d3c.1561386715.git.andreyknvl@google.com>
 <20190624175120.GN29120@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624175120.GN29120@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19071711-0020-0000-0000-00000354AA32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071711-0021-0000-0000-000021A87C56
Message-Id: <20190717110910.GA12017@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170135
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 24, 2019 at 06:51:21PM +0100, Catalin Marinas wrote:
> On Mon, Jun 24, 2019 at 04:32:53PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends kernel ABI to allow to pass
> > tagged user pointers (with the top byte set to something else other than
> > 0x00) as syscall arguments.
> > 
> > userfaultfd code use provided user pointers for vma lookups, which can
> > only by done with untagged pointers.
> > 
> > Untag user pointers in validate_range().
> > 
> > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  fs/userfaultfd.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> Same here, it needs an ack from Al Viro.

The userfault patches usually go via -mm tree, not sure if Al looks at them :) 
 
FWIW, you can add 

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index ae0b8b5f69e6..c2be36a168ca 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1261,21 +1261,23 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
> >  }
> >  
> >  static __always_inline int validate_range(struct mm_struct *mm,
> > -					  __u64 start, __u64 len)
> > +					  __u64 *start, __u64 len)
> >  {
> >  	__u64 task_size = mm->task_size;
> >  
> > -	if (start & ~PAGE_MASK)
> > +	*start = untagged_addr(*start);
> > +
> > +	if (*start & ~PAGE_MASK)
> >  		return -EINVAL;
> >  	if (len & ~PAGE_MASK)
> >  		return -EINVAL;
> >  	if (!len)
> >  		return -EINVAL;
> > -	if (start < mmap_min_addr)
> > +	if (*start < mmap_min_addr)
> >  		return -EINVAL;
> > -	if (start >= task_size)
> > +	if (*start >= task_size)
> >  		return -EINVAL;
> > -	if (len > task_size - start)
> > +	if (len > task_size - *start)
> >  		return -EINVAL;
> >  	return 0;
> >  }
> > @@ -1325,7 +1327,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> >  		goto out;
> >  	}
> >  
> > -	ret = validate_range(mm, uffdio_register.range.start,
> > +	ret = validate_range(mm, &uffdio_register.range.start,
> >  			     uffdio_register.range.len);
> >  	if (ret)
> >  		goto out;
> > @@ -1514,7 +1516,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> >  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> >  		goto out;
> >  
> > -	ret = validate_range(mm, uffdio_unregister.start,
> > +	ret = validate_range(mm, &uffdio_unregister.start,
> >  			     uffdio_unregister.len);
> >  	if (ret)
> >  		goto out;
> > @@ -1665,7 +1667,7 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
> >  	if (copy_from_user(&uffdio_wake, buf, sizeof(uffdio_wake)))
> >  		goto out;
> >  
> > -	ret = validate_range(ctx->mm, uffdio_wake.start, uffdio_wake.len);
> > +	ret = validate_range(ctx->mm, &uffdio_wake.start, uffdio_wake.len);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -1705,7 +1707,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
> >  			   sizeof(uffdio_copy)-sizeof(__s64)))
> >  		goto out;
> >  
> > -	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
> > +	ret = validate_range(ctx->mm, &uffdio_copy.dst, uffdio_copy.len);
> >  	if (ret)
> >  		goto out;
> >  	/*
> > @@ -1761,7 +1763,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
> >  			   sizeof(uffdio_zeropage)-sizeof(__s64)))
> >  		goto out;
> >  
> > -	ret = validate_range(ctx->mm, uffdio_zeropage.range.start,
> > +	ret = validate_range(ctx->mm, &uffdio_zeropage.range.start,
> >  			     uffdio_zeropage.range.len);
> >  	if (ret)
> >  		goto out;
> > -- 
> > 2.22.0.410.gd8fdbe21b5-goog

-- 
Sincerely yours,
Mike.

