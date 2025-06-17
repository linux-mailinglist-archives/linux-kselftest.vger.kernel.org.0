Return-Path: <linux-kselftest+bounces-35202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069FEADC909
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 13:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC603B7171
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B704B2DA777;
	Tue, 17 Jun 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBPPB2Qd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019D2980AC
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158342; cv=none; b=PvESYn/19jeqjsma3zfeV4DoW6wY0+AN2hDSPchhSddusTVZecb2EA1cEQoEY4axgVkv0b5HdXwK9Y6kX40JtNrF7tnqZvxQVpBIkZTYpbRCPCxJV+MSgiff765uCjMKlXZ9fni3f1z/KzKgU86ZZOolUMKA3/5IvOOvuuln/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158342; c=relaxed/simple;
	bh=0um0R3zeYp1Vpz2CP5NnfVmYK0iAYL/nakFl/p17qOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbEZFZlYSvYiEvUqFDs7d62A9vwzKFz7ombbFlTyCWOeUzHKHpfQRFvWURu4bVo7samXnSlOUSa84V2OynbPhGalAFhjbZtnPH2mkO2QiWM+kLfgMd3fFaLfBEcuSflxCtD9cpt9pKGPt6JCr3o3AXycczMWS0M8z7GbaFpfHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBPPB2Qd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750158340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TiYdceZwMX0acoVDusyjf9I10Ybg+SrHFujR2B70YK0=;
	b=IBPPB2QdaAaZnE1KnUnLU6fWQX01ehZ7hNZNhQ4z5Tbt3qEK+vUSH0c2CDRTpUrr3M9Ys1
	4ljYzWRqZ97b5dJCpEyW7FEnrWdim6xnpofHdc54+TAoZL6+P4IhF9skQ9xOYtZkyz8T3h
	YDgpRbdmI3tb2YFFyL/Tc9jtaiVUy+4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664--BLfXEdfNw6yvtH9Eb6OFA-1; Tue,
 17 Jun 2025 07:05:35 -0400
X-MC-Unique: -BLfXEdfNw6yvtH9Eb6OFA-1
X-Mimecast-MFC-AGG-ID: -BLfXEdfNw6yvtH9Eb6OFA_1750158333
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 087B9180028F;
	Tue, 17 Jun 2025 11:05:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.84])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00C901956094;
	Tue, 17 Jun 2025 11:05:25 +0000 (UTC)
Date: Tue, 17 Jun 2025 19:05:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	kbusch@kernel.org, Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: selftests ublk UBLK_IO_F_NEED_REG_BUF undeclared
Message-ID: <aFFL8DQufPXnerlm@fedora>
References: <CA+G9fYsiWN1gWhHBk9uruDBzVHvLYCTL-VcxU2iiPMcS1EXyBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsiWN1gWhHBk9uruDBzVHvLYCTL-VcxU2iiPMcS1EXyBg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Jun 17, 2025 at 04:27:31PM +0530, Naresh Kamboju wrote:
> The following build warnings / errors noticed while building the selftest/ublk
> with gcc-13 and clang-nightly toolchains on Linux next tree.
> 
> Please suggest if I am missing something in my build setup.
> 
> Regressions found on arm arm64 x86_64
>   -  selftests ublk
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducibility? Yes
> 
> Build regression: selftests ublk UBLK_IO_F_NEED_REG_BUF undeclared
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build log
> 
>  CC       kublk

Please run 'make headers_install' before running the test.


Thanks,
Ming


