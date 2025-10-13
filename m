Return-Path: <linux-kselftest+bounces-42992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E1BD2DCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E1974EC1E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6526738D;
	Mon, 13 Oct 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JL/UwamO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1/3Pi8U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F25265630;
	Mon, 13 Oct 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356618; cv=none; b=prEvynsJyKXmxR5inhYz8AZneYLxApnP6X7ZtdPBOFsc/nzn4saEi5TgWgrX1IKi4BWg29mvKCL8ZCbY6tXP0o4QwkSHfc+lwetvU8QVbX+YlsiQ++eXwfqxoBjH2aqtTF/HqKNSOWx/tMUpZuFr1S3KfRP5p98/dLL6/BcPJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356618; c=relaxed/simple;
	bh=yjPOEDIDtRuH2XBFaYTg5kgqsPJco6rZNlDCbLKgDW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVGQY61iJvQ1kL+pSxDEtELY5Q88NUQe4JRzppbZk1k5Pk7KcCNaD9w1fLGQLSmBfXFHmnhlG7/L6o/HtRyHSgLTISDRnAhyDpkrezjsajGpltozjeNQp6761fIEoYLj20B5obJVfj+MjRxFCSJgs7JS8LFcBqMWpFHePzY61l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JL/UwamO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1/3Pi8U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760356614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjPOEDIDtRuH2XBFaYTg5kgqsPJco6rZNlDCbLKgDW4=;
	b=JL/UwamO3nx4kte4GLXKYJGXWDsEUFLwmarFcJnK5xu1KqJ6txNVDi5eeN/un+XivT/7P4
	3hW0azrYEXXgk4biUXbjFoVnVtUhf34PdbFs9P6wkGPX6xE7yAqJt4e4zBMBwSs0uHpCVj
	AcXJ7EfCEpQg5sGH9hbYP+/ZuUpJZSf2qQ9xbTegStnM6NCNnB+iTSO6ZCdKj+/STDxziX
	EAF/xh3RrFDJYhkb2BqZPY3aIKod/0JclYdmRzLMh/892g8SdK/Mq7rV2SZZiJ4+LK1pU5
	fOW/YoZlVbjaL21rTZznwVv1Ap3NFKrk8KwkLYu96aKXKVWwlttFKTr7PZ0Cwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760356614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjPOEDIDtRuH2XBFaYTg5kgqsPJco6rZNlDCbLKgDW4=;
	b=a1/3Pi8UsXT3IAG3DPuI6TV4xB9pjH3PGdMIlayMIu4i3KlxsxpbsU3L6vGT1oUdBC0UyA
	tIv/MxjTMqr691DQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, John Kacur <jkacur@redhat.com>,
 Waylon Cude <wcude@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/verification: Add initial RV tests
In-Reply-To: <03365f64c7f94daa39bcc7df45cac2928af2a570.camel@redhat.com>
References: <20250926094613.34030-1-gmonaco@redhat.com>
 <03365f64c7f94daa39bcc7df45cac2928af2a570.camel@redhat.com>
Date: Mon, 13 Oct 2025 13:56:53 +0200
Message-ID: <87ecr7f20q.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Steve, Nam, would you have time to have a look at this series.
> If possible, I'd like to get this minimal selftest to next together with Nam's
> (urgent) patches.

Right, I completely forgot that this exists.

I am at the final steps in another project, should be able to look at
this tomorrow.

Nam

