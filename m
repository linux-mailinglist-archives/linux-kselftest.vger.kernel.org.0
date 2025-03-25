Return-Path: <linux-kselftest+bounces-29744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E9A701F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC19173B19
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576701B85FD;
	Tue, 25 Mar 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2DBMkfI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B747FD;
	Tue, 25 Mar 2025 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908534; cv=none; b=B8SpvIjDVlpk3WbiayjQqr83tZCLndOvydAEI2oq55aKl5yChLbB1Iqq3J2HgONcqTPt0WwGzlu0cGaPEvlHW/wSn5SM1Fq7u75sKPnJcTXvER5INxuzfWWQAfnfLSaKjwGqcJsZT08we/VuYizhZs93XtJ8ZuK7XItPdjdncvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908534; c=relaxed/simple;
	bh=VqXXB2mEqxFC1LDN9wNCpGmhRpgt0/qkMTPkkPWd4dY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnW3m4rbMxqo9qzhQJVcB8A0KpOVpS5w8eavnKzbQgUCo8a1rEN1xm2Il7CWKL+5CcmhYyUIaqPR4tecXkDQoLIacg1cSkoSFZTqEWPHpWvlM843arxaowZIgxenx767DG3Hwfrma8iQwm6cDtFbg7HcqAyVGEVzXSZbMdRl9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2DBMkfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01250C4CEE4;
	Tue, 25 Mar 2025 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742908533;
	bh=VqXXB2mEqxFC1LDN9wNCpGmhRpgt0/qkMTPkkPWd4dY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B2DBMkfI/uSSpv1o6pTxNQHVEBfVxr54Ggc+RkVvpYM21GJ5Xb3XA1x3/bWBVcyX1
	 UKrvuPTnBVwJW6HTopYUPSxSVOOxVsEW+foQ0KTGwtxLuvwb93C2Qm+TEFvL7Pfiok
	 P2j0jW98Zun1ewC9zsXZuW5C0WZp/w5QLEncqx/On94iZ4Ly9NR5NpvCiPJSkrMakX
	 XWf0MwJK/DCU3wSFVVFwkFxtMBPeIJimJ+rZjT6wXyEvOerqczN4gF3BlMkTMpXOA9
	 q7HtXi/ENou9ep1HnYCDlDAwh/odi7yheS4eiKcsb4YUyylAYazG1drRMy+8vpKApw
	 D7+X9fOBykrnQ==
Date: Tue, 25 Mar 2025 06:15:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: 0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/7] selftests/net: Mixed select()+polling
 mode for TCP-AO tests
Message-ID: <20250325061525.01d34952@kernel.org>
In-Reply-To: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
References: <20250319-tcp-ao-selftests-polling-v2-0-da48040153d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 03:13:33 +0000 Dmitry Safonov via B4 Relay wrote:
> Should fix flaky tcp-ao/connect-deny-ipv6 test.
> Begging pardon for the delay since the report and for sending it this
> late in the release cycle.

Better late than never, thanks a lot! :)

