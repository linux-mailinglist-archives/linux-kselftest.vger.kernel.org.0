Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F07349CCAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 15:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbiAZOuj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 09:50:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235611AbiAZOui (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 09:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643208638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=24kMRqjE/mfts4KLJ2o54Nm09IK0MxEZxPEl8a0jE8A=;
        b=T9ngbtj+gXNjZe3/raBFhA/tQxQ31y2lNQI7IWEPg7nTQoxa58KSNir+TCNvfNWW/vZy3C
        PI5p5HvIdA4n5T+Rls2a1lzsmrL303whPRer2g2c0uXhoTnzgw89auXaV0NxnhA7+XQNx1
        2rMREBHMhyjeazW2HFSKdWFCwB+3sW4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-_GPkYgi6PDG4JQCGVhHx1w-1; Wed, 26 Jan 2022 09:50:37 -0500
X-MC-Unique: _GPkYgi6PDG4JQCGVhHx1w-1
Received: by mail-ed1-f71.google.com with SMTP id j1-20020aa7c341000000b0040417b84efeso16712540edr.21
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 06:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=24kMRqjE/mfts4KLJ2o54Nm09IK0MxEZxPEl8a0jE8A=;
        b=qk+IVUWy8KW+HQ1c/TadRtRvRNxuuW0YCwT86RqjrEhzajF6RyKe4doFio5VnOWTNj
         zPy3wLj8bnzSmznVyv2gle1rZ36MM/fhNHh7uu9QyuOEZpvF1JBxlozgnBOUAHYDTBtQ
         zyoUA+WWalX+/pkFUVnlFkjzcIXuQaKq66++E+2K8o47dpGYRLBqz0wO1lNfLNAmLYZZ
         oLOwZRcOAjQ2Q8NqPjX5yKh/gzaDsBB+6A9wRclqAEL+I59XBeE5LSftV6DZS6KCxr4d
         S9+9Z0XWrfq8y55WMnYOS2TqEWXpys+qUTXK7H+u81/tP8zjDMgbZEF6/2+KzgLxt3TU
         LBTw==
X-Gm-Message-State: AOAM532M/gnnUgM5cmrNeKkw0NnXnrsXNOmzPEMxBAhIbzQvZXvOCDMD
        q7fp2FQMSXCaH8qwWoh4kf4srtQY67yuRGJ9Uc9mq6UqA6OqOzEA0Uw7goAdIbSuVeyqJDUrSvf
        v30DoIBtK6LIaYueMEOh8cyUaY3gT
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr13639039edz.203.1643208635945;
        Wed, 26 Jan 2022 06:50:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBd/vEwW4Z/avy9Ldd+WhZ42kptNp4wXi1sz3pTq9kDD70yxHrMmoYahynWpglFwM0w/OaQA==
X-Received: by 2002:a05:6402:190f:: with SMTP id e15mr13639020edz.203.1643208635749;
        Wed, 26 Jan 2022 06:50:35 -0800 (PST)
Received: from gator (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
        by smtp.gmail.com with ESMTPSA id k24sm5955935ejv.179.2022.01.26.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:50:35 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:50:33 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Message-ID: <20220126145033.nwsf2g7dim7yeoz2@gator>
References: <20220126135319.1918802-1-broonie@kernel.org>
 <20220126141741.zxxltis5zdtjzz33@gator>
 <YfFauhK4FuM1/I8S@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfFauhK4FuM1/I8S@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 26, 2022 at 02:29:14PM +0000, Mark Brown wrote:
> On Wed, Jan 26, 2022 at 03:17:41PM +0100, Andrew Jones wrote:
> > On Wed, Jan 26, 2022 at 01:53:19PM +0000, Mark Brown wrote:
> 
> > > -	vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
> > > +	ret = vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
> > > +	if (ret < 0) {
> > > +		pr_info("Failed to create vgic-v3, skipping\n");
> 
> > Please use 'print_skip', which appends ", skipping test" to keep the skip
> > messages consistent. Also, print_skip can't be disabled with -DQUIET like
> > pr_info.
> 
> I see.  It might be nice to convert these tests to use the ksft_
> stuff...

Indeed. I'll add that to my TODO.

> 
> > > -	/* Distributor setup */
> > > +	/* Distributor setup - test if it's possible then actually do it */
> > > +	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);
> > > +	if (gic_fd != 0)
> > > +		return -1;
> > >  	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
> 
> > kvm selftests generally asserts on failure with the nonunderscore
> > prefixed KVM ioctl wrapper functions, which is why you appear to
> > be forced to do this nasty dance. However, kvm selftests usually
> > always also offers an underscore prefixed version of the KVM ioctl
> > wrapper function too for cases like these. So we can just do
> 
> >   if (_kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false, &gic_fd) != 0)
> >           return -1;
> 
> And the _ version is OK to use in the vgic code?  The _ makes it look
> like it's internal only.

It's extra OK. Anything in lib/* or lib/*/* is internal to the lib.
However, it's even OK for a unit test to use the _ prefixed functions.
The _ isn't so much about being internal as it is about being a raw
version of the ioctl wrapper, which returns error codes, vs. the
asserting version of the wrapper which only returns results on success.

Thanks,
drew

