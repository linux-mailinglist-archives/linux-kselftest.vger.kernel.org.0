Return-Path: <linux-kselftest+bounces-36398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142EAF6AA9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185253B12D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F7293B7F;
	Thu,  3 Jul 2025 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="denmHcXX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C34291C30
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751525092; cv=none; b=AaddV8ATWlNrk3NVoNGjENGbIJe/Icuxjhu3KCF9d5g9nnCCXfLxNbmgPsCPDXsjQ1ByJREcJ09ORTHg+lVypQxJZNBaqVXeNyKJzRuH1cDQnx6S7uzjMS1NYxHBEs9I09snodtNEYV7n357y1Mz5Rq1C9QFRrz6tCMKNHCWOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751525092; c=relaxed/simple;
	bh=hpFYLV8ogJfKB0nmps6HY6WbbsMeyCGnB9/GFoUFXHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzMYLZ7+3dN8937LDVgbnG5LgZsI12VQuyBnc5oi4OkIHhYeKuqSs6FBgnzN/oPWUkbBuTogwot0xH/qXQveeX3Z7SngReaxt0HWkjffY8GV9nVCMoWL1fVNOF2dhgSBb0xjfTOkp7Gyf3NPUWnXyuxbBVr4S7ts6BxEeZFmHok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=denmHcXX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751525089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJ7q0V9kF6LpjhO3dWBRMm1GDYk0h/5qsRyzs/9AW0o=;
	b=denmHcXXmax7oCF4zzReiiGAVyI4jpaNeAFkLUrxevpKyo/Vkw/i7rmVm7qTCJMfEeAnKB
	/bm843AMsr75v4FQfFGPV/gBuzf6K4zhgSbfTj3hZ+Ynr78nq3wy7vmaAUhO9+j5auy3RZ
	Fg5vvnan060CPoOLbX+LlopIBBck/wE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-yQrqLG9AO-ujHHCjFsafNg-1; Thu,
 03 Jul 2025 02:44:44 -0400
X-MC-Unique: yQrqLG9AO-ujHHCjFsafNg-1
X-Mimecast-MFC-AGG-ID: yQrqLG9AO-ujHHCjFsafNg_1751525082
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 584E919560A6;
	Thu,  3 Jul 2025 06:44:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.67])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA45419560AB;
	Thu,  3 Jul 2025 06:44:40 +0000 (UTC)
Date: Thu, 3 Jul 2025 14:44:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: khan@linuxfoundation.org, kexec@lists.infradead.org, dwmw@amazon.co.uk,
	mingo@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/kexec: fix test_kexec_jump build
Message-ID: <aGYm1BARlztCoCLT@MiWiFi-R3L-srv>
References: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 07/02/25 at 10:17am, Moon Hee Lee wrote:
> The test_kexec_jump program builds correctly when invoked from the top-level
> selftests/Makefile, which explicitly sets the OUTPUT variable. However,
> building directly in tools/testing/selftests/kexec fails with:
> 
>   make: *** No rule to make target '/test_kexec_jump', needed by 'test_kexec_jump.sh'.  Stop.

I can reproduce this, and this patch fixes it. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> This failure occurs because the Makefile rule relies on $(OUTPUT), which is
> undefined in direct builds.
> 
> Fix this by listing test_kexec_jump in TEST_GEN_PROGS, the standard way to
> declare generated test binaries in the kselftest framework. This ensures the
> binary is built regardless of invocation context and properly removed by
> make clean.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---
> Changes in v2:
> - Dropped the .gitignore addition, as it is already handled in [1]
> 
> [1] https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com
> 
> 
>  tools/testing/selftests/kexec/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
> index e3000ccb9a5d..874cfdd3b75b 100644
> --- a/tools/testing/selftests/kexec/Makefile
> +++ b/tools/testing/selftests/kexec/Makefile
> @@ -12,7 +12,7 @@ include ../../../scripts/Makefile.arch
>  
>  ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
>  TEST_PROGS += test_kexec_jump.sh
> -test_kexec_jump.sh: $(OUTPUT)/test_kexec_jump
> +TEST_GEN_PROGS := test_kexec_jump
>  endif
>  
>  include ../lib.mk
> -- 
> 2.43.0
> 
> 


