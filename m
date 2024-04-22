Return-Path: <linux-kselftest+bounces-8623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D667A8ACF1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A6E1C20E58
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29BF1509A6;
	Mon, 22 Apr 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/3HMX7X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CN0FPGUX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA2513F45F;
	Mon, 22 Apr 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795324; cv=none; b=I29wZ4EVQ6w66JFUredfPX45axWqAijCVMQAlEFnPg9cXyAcl4Fetrk3ra3uea/7OLgJtEqK+L+KX+O+7f2UPFn+HCrW1+ZI50iOSPe1U+vGCoPlEFCNe84sCVwFhCokqgHZG47SmA/xEopTwB0OuomfA7S10UgjnL3AqQo6vCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795324; c=relaxed/simple;
	bh=jHU8RY1gV/J1aWvxPDMHHh3ZFKNBADg4moQ3sz7UJl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKoCZciKhSCa6THoFEn2UWZQKMwGYiyTvqdEWYoNklhjuglQGnmz8hVvOio59ev7GmFY2mhbnfp+tbvSLN+MGfa10xoKqGdNCAQkS3Cpfzk58Evvtmc8/uYfo5ZDGPuBr9fu8HAG402z3RNrE7zVIuhzGa3/c7pasZmw0SxGMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R/3HMX7X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CN0FPGUX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713795321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNo+/8w8RvWPnILfr9IOwTATAIt7FbEbtaS/MwLPhsw=;
	b=R/3HMX7X6/xE5ZA4RrlcZJPh9IhRmcRLGv03FJYSaSOSreK/gAfaPNz1qO2lKG1ugruazx
	sn9DsKPM4HQgb8hby2Yhe8NmcBgBrExVtZpfAT35AOWHy77VONcvkVQP/25AF4aOOm0vAH
	Mu5lCcD+iVo1w9uXf3vKFJxR18RIQkCUZHL069vKiT0GcLwwT0GO0FTevVWfE2i5Sqoch2
	LIMvbqmJxCDgsxzxzOPKgKGqFX2pkrrS0tVAmlgCXCU3YZFpQ2ruG0RngXTuIp2I/B6SBs
	fMG6nVRlCY9IRt4abaUGv8m/L4WIjuCZn9eqRLZ0O1x2Mp1zTY2bZ5v7wHsWTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713795321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNo+/8w8RvWPnILfr9IOwTATAIt7FbEbtaS/MwLPhsw=;
	b=CN0FPGUXIi9m4bHrLJZfF0DA7P4MUC2I7cae3rdMWuLWJsyLmcjwxH/GeRreXUS/c+xvzc
	j0476Npg0Pqu35Ag==
To: Nathan Chancellor <nathan@kernel.org>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Nathan
 Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] selftests: Make ksft_exit functions return void instead
 of int
In-Reply-To: <20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org>
References: <20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org>
Date: Mon, 22 Apr 2024 16:15:18 +0200
Message-ID: <87zftlv5zd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 17 2024 at 08:37, Nathan Chancellor wrote:
> into the more idiomatic
>
>   if (ret)
>     ksft_exit_fail();
>   ksft_exit_pass();
>
> as well as a few style clean ups now that the code is shorter.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

