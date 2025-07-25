Return-Path: <linux-kselftest+bounces-38002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42020B122E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 19:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098F7AA5F8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803722EE968;
	Fri, 25 Jul 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl1ze9IA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DCD1FC8;
	Fri, 25 Jul 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464039; cv=none; b=dZ9zaDtgaBm3Er/28pSXN7kTWbtd9XIjsds3Ze4jDQ/WUwzY5+1DpF9yALZwL+Xe4QQXQqZLS2d7AWHzfnDYeKD0MLMXNDqw+LoEv/gZ73YrlmZhAAaDP0nizvm2QzktZ0DJUpUeNRzipoAzua2TdueED0rb1itcGr7AfuSyMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464039; c=relaxed/simple;
	bh=HIKxRtuEADT61vpZ22r6SOsprmqG8Jn7ATscClrH5YY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsRrbhIJ98YuCMRy9vaPdXxZMGjSQyk1eEoLILdx7JhBaokTvMj5aDd9uJNslD0TWsdDhuq4C2xg2e7a7CPegh79kt+ME72jm18Dngf5serVjWem5J63ZeTmlXGVdmO8h/5ltX3A8vSGSUvFm7IBYX5C9qmH7oBudw4yn6G0fa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl1ze9IA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011EFC4CEE7;
	Fri, 25 Jul 2025 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753464039;
	bh=HIKxRtuEADT61vpZ22r6SOsprmqG8Jn7ATscClrH5YY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cl1ze9IAETlkY7AdHFID+G1hK6MykPOqlXzTCQ2KxQDuVMkdt279jLdzT4udN9NAp
	 Yj79RuEQCoEOQSd1D0bP2bpOQyynDOLfIikqgZ6nE7eeCIZy0U6wHUbKTiRn4HfCZX
	 HVPfvE19VQ4f7OPU1xcVVnoxw9zqTo9haxl1oGnGCIssAO155vVvClcag4WMx7Aaj/
	 pN+TTjA31bS2rBJ4JgRuXy0kvo8LqipVQMKhGhiTdNtzcuyzUJOMWFao6TqPnbk8Xy
	 vjwkke6HZEBQF5n0QNgjolhXqyYUc7LMouOnp/OZlBJmD0BoFtZ7aiHQaVvmNnufAB
	 kIwbnQlqA8Bnw==
Date: Fri, 25 Jul 2025 10:20:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <dan.j.williams@intel.com>
Cc: <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Crediting test authors
Message-ID: <20250725102038.403c4338@kernel.org>
In-Reply-To: <20250725102019.7add0be0@kernel.org>
References: <20250725080023.6425488c@kernel.org>
	<6883b3046b640_134cc7100ad@dwillia2-xfh.jf.intel.com.notmuch>
	<20250725102019.7add0be0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 10:20:19 -0700 Jakub Kicinski wrote:
> Reproducer: test.case.path # 001122aabb (optimal) commit of the test case

s/optimal/optional/

