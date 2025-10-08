Return-Path: <linux-kselftest+bounces-42875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88645BC52E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 15:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE84EC773
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C128466C;
	Wed,  8 Oct 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dis6zV80"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A834BA37
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Oct 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929876; cv=none; b=L1YIjpSV7finOiW1e5furASvMqfOusmGi2zNA7kxEgEQP2o/lgz/7pk82MGKTl0Gz71PJCPj8vkti9TsvHACR+HqgVSYIJrl0jH2CME1jQWpCQqsCKRsEIiM0An12lGUKvL4ul7o0neKtOA44medfSCW51/YJHJX/pniiUzfElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929876; c=relaxed/simple;
	bh=+z4cw7Kh0UDzc/Mzt4faADLbEJpWktNXzAB2U/Vl3lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1h4JZRr2Uefg78DZN93lxYPKhwvvKQ0AEDaIPxaS9gRwLUuUkvOaTJFAbNzmO22trIfZnabW1hkSByRw4ih6t29Mvuk9iDm9u8aRi+B0eRvN0BOWqjf2fMYZW1gcCTYQo53YBmSg5mY0KyzCPWnVn4y1AvDYZmXXvHMpytYKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dis6zV80; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fb48315ddso12922565a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Oct 2025 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759929872; x=1760534672; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BI/TCoi4LzxSA8XfIjZuhJqyGS6WzPwjqlZF4XU4Rk0=;
        b=Dis6zV80iSK509rUExGQLSoy+RVXoHXGi8fTj6CG2vV7TtkqfKxGu9xq493Ha1XYuY
         C/WWVZygORk25MH6P9GygIVR2vQyc9iWduSsCtLG5tXwKBa9VUD1bmWQz4mcXSKboCzn
         /Gm6Uj8pyhxSYjUC4pPFiL6Jly8kNdpz7bzdXpDL6wSO0hR8Bx/RsfDzY8Jjwu41t2pz
         h9T8Yyq2ma86O1P99CInYl/YJ1mK6IXSKvEcob8b03FTEKboVrPkFzkkSjTIV5+LIMFg
         kASyOJGAMBCCXk1C35AMUkgfKw54H5QXDIa7Cd2LJpS4o7SdBGWK1Le6TBl9Lcz6Q3d5
         2ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929872; x=1760534672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI/TCoi4LzxSA8XfIjZuhJqyGS6WzPwjqlZF4XU4Rk0=;
        b=O5KAjwIJj6J4vgBvkwXhP0vv94Iok/bPC4cUc54fuclHsll94/27QK7b3LOeDRaOME
         cW606c0g5n4CiZSl2yJyp7J8RD4CtsGxEtpKvKQX37s2DlqWbxlxambO4AqG2IK4ev9Q
         eIQZzFWurZ/WUR/oODfFd8+9fNS4qLB4g/De9nY/55umJX2PiK5OE+8LgJ6/Vtcbsvrd
         m7e+YeoJC7m45rnBn/2WHsYalH1fXbKGUDa4t8427Ie4wWhkWfEgiM1MBsLW1jZRemHY
         k8NurTUhLe+QCsauJMxqZxivrCHadXys7QXXPH7m4nPPFHm3ZjnQeQTpnsoB/82TLxYH
         CzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2zko4krcpHxmoCeus6aZG5WsdZkwF4pcLNEXik45T/gv/vgnZTp4LqHKma6b9B8TRygveQbsGq9DI+0ootvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzAQ7oJq798A9V+yAyteSo+N4SJwWu2e9qyj+4NLjd0IeLYjo
	QuaDKebsUNsal2x3V8A4+LIQ8RsIwRJcWTXvDszQzGpEcb5V3f2y4gHZ
X-Gm-Gg: ASbGncsJLplej+hmpO9FoT/uHlK3IBBXF0kK1J9NDLTiiAvXbO5CwrXUJNYgye4k+7X
	mK2d58wsCZzP6LiQnjCOgouH3m2VopoVm+JRJg2SHdZrv/Hrl/gI3rd6FnbsiTDNYgp9vYrl5Jn
	m/5By/jnlvC8i64jKnQ9QgEXF4Sii4k5IOxoaDkhZPN+2hnaV9j/zhAQ+ho1woOqg5+27uJjnrp
	4as4LayqBlXCyh5I2J0jf83l4qZP/7lwoqHK37bg9TZu+jnyP0vaLlis3skrJo/EPJ9cqKxyKrg
	H3D21NP/SXwGPpdpDOtSvIlvDP0RLl1d3tRxYG0eZZ4YmegTmeKdp2N/02g0593yoWWHpMT0+/g
	ALCbPFLPIGF3lyjbA3TTO5eSpDs9/KmyxM8vzpVMPvaaezmYbljf/KpSjNc5fEhjJJ4qLIVvfZx
	fPaDZuXmUEtIAmRFzxl3DIiBWor6e6Rlo=
X-Google-Smtp-Source: AGHT+IFoTe1GsKoLNfXidCZ8Czjg/nCNLCnzrvEUmCAiPJvugQ49+mFzHnMIpycIWZF3p+SyrTr4cg==
X-Received: by 2002:a17:907:948f:b0:b07:c90a:8ade with SMTP id a640c23a62f3a-b50aa08f896mr397894066b.20.1759929871888;
        Wed, 08 Oct 2025 06:24:31 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa040sm1650850166b.20.2025.10.08.06.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:24:31 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:24:29 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, jgg@ziepe.ca, 
	kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix to avoid the usage of the `res` variable
 uninitialized in the following macro expansions.
Message-ID: <rfwgp73zuyctbjgxvdgs67gq7g6glfxdd5peimqjiw5inw5h4g@cgmif7gyplct>
References: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
 <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>

On Tue, Oct 07, 2025 at 03:28:29PM -0600, Shuah Khan wrote:
> On 9/24/25 10:57, Alessandro Zanni wrote:
> 
> Fix to avoid the usage of the `res` variable uninitialized in the following macro expansions.
> 
> ret not res?
> 
> You can simplify the shortlog "Fix ret unitialized warning" perhaps.
> 
> 
> > It solves the following warning:
> 
> Fix the following warning.
> 
> > In function ‘iommufd_viommu_vdevice_alloc’,
> >    inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> > iommufd.c:2889:1:
> > ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> > [-Wmaybe-uninitialized]
> >    760 |   if (!(__exp _t __seen)) { \
> >        |      ^
> > ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
> >    513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
> >        |   ^~~~~~~~
> > iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
> >   1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> > nvevents))
> >        |   ^~~~~~~~~
> > iommufd.c:2924:17: note: in expansion of macro
> > ‘test_cmd_trigger_vevents’
> >   2924 |   test_cmd_trigger_vevents(dev_id, 3);
> >        |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > The issue can be reproduced, building the tests, with the command:
> > make -C tools/testing/selftests TARGETS=iommu
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >   tools/testing/selftests/iommu/iommufd_utils.h | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> > index 3c3e08b8c90e..772ca1db6e59 100644
> > --- a/tools/testing/selftests/iommu/iommufd_utils.h
> > +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> > @@ -1042,15 +1042,13 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
> >   			.dev_id = dev_id,
> >   		},
> >   	};
> > -	int ret;
> >   	while (nvevents--) {
> > -		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> > -			    &trigger_vevent_cmd);
> > -		if (ret < 0)
> > +		if (!ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> > +			    &trigger_vevent_cmd))
> >   			return -1;
> >   	}
> > -	return ret;
> 
> Hmm. with this change -1 is returned instead of ret
> 
> > +	return 0;
> >   }
> >   #define test_cmd_trigger_vevents(dev_id, nvevents) \
> 
> thanks,
> -- Shuah
>

This patch has a malformed title. Please refer to the patch called
'[PATCH v2] selftests/iommu: prevent use of uninitialized variable'.
But the typo `res`->`ret` is still present. Sorry for that.

About the fix, the assert test just checks if the return value is 0 or
not. That's why the variable has been deleted.
By the way, if we prefer to return also the error values, the patch 
v1 just solves the warnings returning the negative values.

Let me know which version is preferable.
Thank you,
Alessandro





