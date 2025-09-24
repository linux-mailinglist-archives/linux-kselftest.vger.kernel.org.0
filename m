Return-Path: <linux-kselftest+bounces-42178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B7B99EB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 14:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612403A42C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13D63009E7;
	Wed, 24 Sep 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WExm/Z0T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01D2FD1C2
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717956; cv=none; b=KDiqryINWFXv9JWbEgqODTVOgyHWTiVrMZhDfFlU04m5OBaRORYNvstpEJqqVw3lweSeC0jTh71SMvT/GexCNCHHbnNoiDxGeakXuyKUwm/Hfu/I95KUwGc1yX7h7pC+SAaASiUbBr4/n1r7EyYcbiYB5d0ySrqd0tUInv6lQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717956; c=relaxed/simple;
	bh=t1PT40Xa4Dq+KyxteCViW5Qsz3L/IkWqFDFMBeyzK9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjGdUvFpn+IdzXUcZtGfGSjiIcaOmJ9xD7XOYTti/GrYlisRRS3kHkj7kSN5aftl+9zKZyalnFmRTKnw8/ZG0Oq9C8+jvNooX12ziMBKjcRZXOqDG+p+3sMEfUX/o1IRQeu+/dCEw74XioShoRtHYgafKZCShUOM5MQCMaCNJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WExm/Z0T; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b7a967a990so75415601cf.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758717953; x=1759322753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6bfo4bnSZkmykbuJKbewat5BPyEoGg+coLh0zjefBOo=;
        b=WExm/Z0T1kJc+/LXf6Jd+Fpdo+qurPVT29ndPiY3s8m56q3qfrUw2uK8mkuf6Bh7+v
         ONxnCnlPE+i24fUDjdAEoC/iwkUTayto2cAJSfllwi8m++cS8CMEMGjX4VbZSKmoY+j6
         /a8VkFeor6UrA0uNV0Vnzvdtl5EEsOicmGIS0xq1HsQTP0tdmOmwiXYTRA6qTzdFo3VT
         wTR1IaQq/reQ96Hmooc4xfjepGmOAFunCpOXBKhWW2Fk7cNsZPAfp8MP6Ao/qYELFBcC
         1Es93UW5pv7l43yixl7raMk+sW7xaAUI7+0MGQOFFjHFpBJgjRyCa6pPkqWEF2qkb760
         nsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717953; x=1759322753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bfo4bnSZkmykbuJKbewat5BPyEoGg+coLh0zjefBOo=;
        b=XTT2E3Hx5aYcSGPnmNRk6f406rF3qo1Y9Wcz2jRGTZZEIfn0/JZO2qVe6RQQl/eZ5U
         ZzKJUUk7hmpXHQhFb96uhcF1cSd1Yqj1XKALG+KYvufeNU0/PFqneTnYrtvjNYojgBr0
         9mSaQzc3sH9wXnpj7hx97XidHphb/JyltYy5XoSTOoph5jgQL9J4Si1rECyU2yV7+Qot
         zPZfDG/Y+7/3p2BuuWWAa/lUTtGZsJ+z4236E/d0HqRXEiN8Lsenkx5NbTLuE2rWe8hK
         2hxehNWF/6hz9MYdZHCD19d+uQufSS0tJpfequ9QQDyeV4IDVUR6hW6igFAoiXJCW3Bc
         ScSA==
X-Forwarded-Encrypted: i=1; AJvYcCVoe15FWt7aORASDCUnNHINHVcoIrdPt72xt36Uk3wWSZgpCgEVsXoPUk5uuiFEK0MYgmOK57rDF8RDTVTsPLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo4+yfWOqraNRlUHcRzW56zEICwnV6EogtW3DgLdzzfiux+b7b
	FDN944/emYabWDIRVzsZyQVMNIr/Pi41fWA+UjazWhRoji4NTM+e/wf0a42NAWqu7zs=
X-Gm-Gg: ASbGnctzDHSptDMHW3hM9+0nqkTfNFo5+icuEbxKL2YZJkJBM9wvVcVmZhI5q1chT7m
	bVBehhmYjPDbxzoFzIalbUqHpFjoLk7VBKw+UeNp4TmMJHq9HpZy9skDsMma2iQ15U+fcJGd8nQ
	vYNRwKXrsqbVgbQJQ0gglcIkzxBDShjb8FcndvWjSjpk1rmzhDdJbNY+Y+Oqf3etpCEHvZw/hdl
	3mHxBuvsYiE2sPdtYiSTQMDjZIWNEgPg+0Q1UaKyGZlHJSZeT/UCOmZ1NzV67M4yPoKMtkECROf
	JNuOd0YREYLbUTo6IQxDV6N8ikbDmCt+uWjYqqFyt4kCHTTC+NpzZPOSpI2TxBbFYOIcrsdG
X-Google-Smtp-Source: AGHT+IGCrzwAZBuNZMLUevUeVR85F+Mp4gKHOXBdC/wrWMdBzNXtEI8v7/3alXA68gxLWQyrIaqIZQ==
X-Received: by 2002:a05:622a:11c9:b0:4b5:f75c:156c with SMTP id d75a77b69052e-4d36a18b80amr70770681cf.28.1758717952649;
        Wed, 24 Sep 2025 05:45:52 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4d0c9a15c4fsm36822761cf.2.2025.09.24.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:45:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v1OsY-0000000B7dC-30kP;
	Wed, 24 Sep 2025 09:45:50 -0300
Date: Wed, 24 Sep 2025 09:45:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandrozanni.dev@gmail.com>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, kevin.tian@intel.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/iommu: prevent use of uninitialized variable
Message-ID: <20250924124550.GH2547959@ziepe.ca>
References: <20250923150108.34309-1-alessandro.zanni87@gmail.com>
 <20250923172822.GD2547959@ziepe.ca>
 <y7xzjzbquglgrmbufbbqksvshuaofod6alql6gqfbzhq6s33pk@dw4ma6kctr5s>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <y7xzjzbquglgrmbufbbqksvshuaofod6alql6gqfbzhq6s33pk@dw4ma6kctr5s>

On Tue, Sep 23, 2025 at 11:38:13PM +0200, Alessandro Zanni wrote:
> On Tue, Sep 23, 2025 at 02:28:22PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 23, 2025 at 05:01:06PM +0200, Alessandro Zanni wrote:
> > > Fix to avoid the usage of the `res` variable uninitialized in the
> > > following macro expansions.
> > > 
> > > It solves the following warning:
> > > In function ‘iommufd_viommu_vdevice_alloc’,
> > >   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> > > iommufd.c:2889:1:
> > > ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> > > [-Wmaybe-uninitialized]
> > >   760 |   if (!(__exp _t __seen)) { \
> > >       |      ^
> > > ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
> > >   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
> > >       |   ^~~~~~~~
> > > iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
> > >  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> > > nvevents))
> > >       |   ^~~~~~~~~
> > > iommufd.c:2924:17: note: in expansion of macro
> > > ‘test_cmd_trigger_vevents’
> > >  2924 |   test_cmd_trigger_vevents(dev_id, 3);
> > >       |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > The issue can be reproduced, building the tests, with the command:
> > > make -C tools/testing/selftests TARGETS=iommu
> > > 
> > > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > > ---
> > >  tools/testing/selftests/iommu/iommufd_utils.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > I think it should be like this?
> > 
> > @@ -1042,15 +1042,12 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
> >                         .dev_id = dev_id,
> >                 },
> >         };
> > -       int ret;
> >  
> > -       while (nvevents--) {
> > -               ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> > -                           &trigger_vevent_cmd);
> > -               if (ret < 0)
> > +       while (nvevents--)
> > +               if (ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> > +                         &trigger_vevent_cmd))
> >                         return -1;
> > -       }
> > -       return ret;
> > +       return 0;
> >  }
> > 
> > And add a fixes line?
> > 
> > Jason
> 
> Thank you for the reply.
> I'm not sure the right behavior the test should have:
> - in the version you proposed, when ioctl() returns a positive
> value the loop ends and the next tests are skipped.
> - in the original version, if the function ioctl() returns a
> positive value the loop continues with the following tests.
> 
> Which one is the desired behavior?

Sorry it should be !ioctl()

The ioctl will only return 0 or -errno

Jason

