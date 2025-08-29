Return-Path: <linux-kselftest+bounces-40285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6BB3BBDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02D47AD5CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D262848BB;
	Fri, 29 Aug 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhtRTQBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482211AA1D2;
	Fri, 29 Aug 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472520; cv=none; b=rrdxZM8Irspjl/VcK0pOZYdMolsAhWccjb6hkbsYXmPCWOGO1/YE2KrmDrO2eFaxHTcGz8sJmLVCg7jktg3GStmqtvaHCEOzjPeFPfDGxHYS/Yk3F3LXI7AB56jIPkpYlmAafQWyPpjUw/OWt+NeK87ZZ1cssMmRpNBEo2gSk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472520; c=relaxed/simple;
	bh=ases17tLv74igGgvIHHpXvVVktOQs8stMw7rFcVzXxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spH6+3V8HKeNM3BKS1p36QHQxjIvm46TOCYd04+fKUTSkkGwz1FQ5uME1m29n1m84UtC2UqwddBg9eGskiJZFqr1vFdHwfiz4DK5z89EPsU67UVBWJf+GuUADToOy+AbUDP/FpmsGMawFD64lY0x6P4ZBYe/3y+SUJviH/jyYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhtRTQBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2067C4CEF0;
	Fri, 29 Aug 2025 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756472519;
	bh=ases17tLv74igGgvIHHpXvVVktOQs8stMw7rFcVzXxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhtRTQBK8GUJDTMZU6bdVKfE9UQPIln9PR3DMIXKAOfxXAh6NeX7AYB/8F/9eF2Mp
	 1vX85ywJu/uV8YbSL1NYScF+iT58MDA/s+Tx2v6OI5j8G4Nv7NlCAy0GPR0izIzhEg
	 r0zocJhvUck6VWmQWJTTDkzUQkYjcpXtgr0l5cLdgvDN/p5ZYc2hnk4I7qZJemM7kK
	 ZNXNf44XLPd/EADTYvODUyIBVCAbE/QGSyLytx7nOSaZYX+ZNmg0ubb+X0BF/Eq0/m
	 b+aiCBTZpuZ8XK6cMkwPL/mWdAqBktImVxSfhJmQdG15NgWJOz6pJ1JyoexxRcNZdo
	 sLdIwfFb+RDmw==
Date: Fri, 29 Aug 2025 14:01:54 +0100
From: Simon Horman <horms@kernel.org>
To: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	dev@openvswitch.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests: net: fix spelling and grammar mistakes
Message-ID: <20250829130154.GJ31759@horms.kernel.org>
References: <20250828211100.51019-1-praveen.balakrishnan@magd.ox.ac.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828211100.51019-1-praveen.balakrishnan@magd.ox.ac.uk>

On Thu, Aug 28, 2025 at 10:11:00PM +0100, Praveen Balakrishnan wrote:
> Fix several spelling and grammatical mistakes in output messages from
> the net selftests to improve readability.
> 
> Only the message strings for the test output have been modified. No
> changes to the functional logic of the tests have been made.
> 
> Signed-off-by: Praveen Balakrishnan <praveen.balakrishnan@magd.ox.ac.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


