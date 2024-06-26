Return-Path: <linux-kselftest+bounces-12786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A7918056
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E67C1F289CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504AA180A76;
	Wed, 26 Jun 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbWwYXXl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D21802B2
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402983; cv=none; b=dCobVDl3myj/cQ0Ygbm4YiPMLLcoxn8QZMv8ur/lANpfgDeEfBLhyfILG7yP9Vd6Rv45B6kYoIFpbQXf673Wo7Xps2kpotr+V1/fISAvKh20+ohCg96fqgazCQ7Eaj75NHfUkrmVb83K3uYf7HxcvGfq3wkKFTf6S2uRNIj0o1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402983; c=relaxed/simple;
	bh=lgWICHNHPuubQOwpPjvNZahWKQ8qhmpoYioYgoXyJo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRWXvf1xmOD28I22c0V2pUsxuMtEumVdNWbnSm9ML4toxeAJ7TCcs0snzip2wX4011WEEqJmllsUsaI4F9Sh+qBKATjAvlvwvphub3h4QhOg9um4YWInE8QTvDIGe7TH5/mXAGV/zMRy7ap341FPI2HIMKT3mqdc6ET7gAghQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbWwYXXl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719402980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeDy1CF3yxC2mGRBAE7SbitMy+vsryV2IcHQr9VWleA=;
	b=SbWwYXXlItClmeVPEm8RAp/wTT3UVT6zaN6AI072lHBk6L8afN3BLQwm9JLbHeiU9vewdT
	G7lbBF01yw0d5RfYKctdwj4YPmyI6bfn2ndVR/e8VgQJiRRtx5DqjzsSqxPQr267z8OvSu
	Ex+n/UE41tpoL6VegBO6PYzvwWvWiNE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-ThZg6DUDNf6i1AC3i71SbA-1; Wed,
 26 Jun 2024 07:56:14 -0400
X-MC-Unique: ThZg6DUDNf6i1AC3i71SbA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB2F11955EAB;
	Wed, 26 Jun 2024 11:56:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2E6E61956054;
	Wed, 26 Jun 2024 11:56:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Jun 2024 13:54:38 +0200 (CEST)
Date: Wed, 26 Jun 2024 13:54:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, mingo@kernel.org, tglx@linutronix.de,
	mark.rutland@arm.com, ryan.roberts@arm.com, broonie@kernel.org,
	suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com, aneesh.kumar@kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests: Add a test mangling with uc_sigmask
Message-ID: <20240626115410.GA27271@redhat.com>
References: <20240626054847.1463889-1-dev.jain@arm.com>
 <20240626054847.1463889-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626054847.1463889-3-dev.jain@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 06/26, Dev Jain wrote:
>
> +int main(int argc, char *argv[])
> +{
> +	struct sigaction act, act2;
> +	sigset_t *set, *oldset;

...

> +	set = malloc(sizeof(sigset_t *));
> +	if (!set)
> +		ksft_exit_fail_perror("malloc");
> +
> +	oldset = malloc(sizeof(sigset_t *));

Why malloc() ?

Can't you simply do

	sigset_t set, oldset;

and then use sigemptyset(&set) / etc ?

Oleg.


