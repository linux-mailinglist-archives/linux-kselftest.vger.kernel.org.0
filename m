Return-Path: <linux-kselftest+bounces-42158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D86B9796E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 23:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4C01B2313A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 21:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B730C370;
	Tue, 23 Sep 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmFNjcKz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454C30BB8A
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663500; cv=none; b=rpoO8HtJARKrOGCSRE7t/ViAQyA1PgvIq0avHD/84w5uzbkdxsliOIOGnGg7EjcL60SCnkVGxQDZsxABeovoKTrbiyilOMUnXRHfceKLqU6OPjez8srAK7u+/MMAYO2bUwNY96opA41/IPWA4u3MV+7Q7N08bkeX+TBRn/ENmes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663500; c=relaxed/simple;
	bh=0+sTDOXCBKnKH/E8c0etG8KcxzezgfK+5x0cwjx0dXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBiS8Bs0SkZFe0VpWdA6TuHozqnSUOqwEUgXqUWgtnmL2PIRHmyPQTIXxULKOo5u6Udx0H5GJ4tpJPZ1HwzYUq7U2wQUO3dYprfTuk6mqmGlC1VGabWlKaoigazVAjkflAeqiAlF36Vv5gewdmdwVcpSMrzkn3Nu0mR8QY1L6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmFNjcKz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b2ef8e00becso347064166b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758663497; x=1759268297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DjUCuu3OWodmRQYhhBu9wo7DG2M9yDqPmVSCIb0J94s=;
        b=MmFNjcKz0tUCS1PBrTDugQekTj6OehYnhNXQzSY6YaSdffgYW7begB/0ph9/9sDUPO
         dW6K7bTOCuxdvIhZqLLMGu0R0+S88Rk5LbfPqpdq+5BCasZwQXgma1+Kd8xCbpubBFmK
         uYApODTks1LlI1b8W7DnM9vlyS3/dq9tpFV/HMQDJ0+9zSdpnvnhZ7T0o6m89VEW5mSu
         Pq8wuNNaU/zmpL007lkCzuKh8a7WR3dcUj/v8xfG7wEBe7AFr0K0nbesU24j/qErsj3g
         1176Hp2e+assgZzO+xYE3RqRgbjC7/12tOfnT92rhJyrYaBUCeI1o6/h6SMC1ao0LPkB
         Wr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758663497; x=1759268297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjUCuu3OWodmRQYhhBu9wo7DG2M9yDqPmVSCIb0J94s=;
        b=o+/Ij3xqXQvXZNawyN3nS5SMsjam9oF3yhnZl2o3D0E4zCLdJXTC5oTS9MT7ilXhZm
         KOVb9crX0pHHQzU7xRSsJL4saLxkAw1fD8hmr0vX8D1sSaQ91ruz0JFx2FctTGl2mat1
         Jy7mAxrckaYqk5ZEzAgwDhqXDICMT3bJK+pXXrw3ASK6dpl6IgPTETRv7OgX5irRTquR
         iVL9AwdFqG1HcgcI9Lw1vYLKZ2sWejWS8JYtDH1KSvFtXn/NaVBBA8XFIIZfJWB5428i
         7eOtKPbCV8+PjKEUj6/EGEpaRZaWpEXI/7wlOUfdguWV9HrM0Vb+14eQMfy1IKBvIy4q
         lwIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCzra+IBeAlT8h9PdQJat7DW8+cgUzMPuv6QJdCchgiPyGsdu9l1CgDhf/IllgYi1Vc7Xb6oj5xF1suja0lvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6RASRqmTBLENzkWq4hgKdEQl3LgVwPTcsVBuVc4qexp73ARG
	fF/Lox1ebyYk4exBiJwJ8j5Y0f2BHfXDnF6nkTv+Qg2k2LfZ8i7Pd2tDjIy8Zp+T
X-Gm-Gg: ASbGncttvL14EWusR2QcdAKzHvBFkNDjKCKUnYqZEOQkkPbI1Ui1lZnbOIc8b3BYqtD
	97uz8hLmOVffsGEUEt+QS2dpi5Pvbe55olgjze577sxeXTPoGKHdA1QEYQkg0CrbcySM8LGZ/J2
	PYxiEV3IMF9GA4qG/GFow0dt5sPu2OssD5vmqhOvZ5c7Hf0kKfwYCOMf+KuTv6e0w5NWgsTysFR
	3ok3phYkNnm7RWU4vIqpkCwCVIAoWby1G4vJNAEtc0D+/abo3LuzWo9J1JfQV2EUN0I7jxPc3E8
	RNKvEvpx9UDhIpiOn+HZ0O+QWIrX+YPbeaKA2+XCABJ9AAiJ5IBAINeNrvH7ImcfvrobVgSQl2o
	zIu3x1APfOrg4+bvvFIrBryQ/eFP+ErXXwzXSTI2lpMK1AY1YxHR6ACeYsaZo+D/1r9RI6XI+
X-Google-Smtp-Source: AGHT+IHxozFTQ2+DY5RuRtE+n73rly9QqmgY4I9v3ctYiEzc8tI31JUkH2hxHnGKb+bQ1Sc7TQ8YRg==
X-Received: by 2002:a17:907:7f92:b0:b0b:20e5:89f6 with SMTP id a640c23a62f3a-b302c4f1810mr388461766b.60.1758663496494;
        Tue, 23 Sep 2025 14:38:16 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2adc17af65sm681037166b.19.2025.09.23.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:38:16 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:38:13 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, kevin.tian@intel.com, 
	shuah@kernel.org, iommu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/iommu: prevent use of uninitialized variable
Message-ID: <y7xzjzbquglgrmbufbbqksvshuaofod6alql6gqfbzhq6s33pk@dw4ma6kctr5s>
References: <20250923150108.34309-1-alessandro.zanni87@gmail.com>
 <20250923172822.GD2547959@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923172822.GD2547959@ziepe.ca>

On Tue, Sep 23, 2025 at 02:28:22PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 05:01:06PM +0200, Alessandro Zanni wrote:
> > Fix to avoid the usage of the `res` variable uninitialized in the
> > following macro expansions.
> > 
> > It solves the following warning:
> > In function ‘iommufd_viommu_vdevice_alloc’,
> >   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> > iommufd.c:2889:1:
> > ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> > [-Wmaybe-uninitialized]
> >   760 |   if (!(__exp _t __seen)) { \
> >       |      ^
> > ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
> >   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
> >       |   ^~~~~~~~
> > iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
> >  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> > nvevents))
> >       |   ^~~~~~~~~
> > iommufd.c:2924:17: note: in expansion of macro
> > ‘test_cmd_trigger_vevents’
> >  2924 |   test_cmd_trigger_vevents(dev_id, 3);
> >       |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > The issue can be reproduced, building the tests, with the command:
> > make -C tools/testing/selftests TARGETS=iommu
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  tools/testing/selftests/iommu/iommufd_utils.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I think it should be like this?
> 
> @@ -1042,15 +1042,12 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
>                         .dev_id = dev_id,
>                 },
>         };
> -       int ret;
>  
> -       while (nvevents--) {
> -               ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> -                           &trigger_vevent_cmd);
> -               if (ret < 0)
> +       while (nvevents--)
> +               if (ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> +                         &trigger_vevent_cmd))
>                         return -1;
> -       }
> -       return ret;
> +       return 0;
>  }
> 
> And add a fixes line?
> 
> Jason

Thank you for the reply.
I'm not sure the right behavior the test should have:
- in the version you proposed, when ioctl() returns a positive
value the loop ends and the next tests are skipped.
- in the original version, if the function ioctl() returns a
positive value the loop continues with the following tests.

Which one is the desired behavior?

Thanks,
Alessandro

