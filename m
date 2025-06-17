Return-Path: <linux-kselftest+bounces-35154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E4ADBE19
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 02:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA667A8800
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 00:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D25B7081C;
	Tue, 17 Jun 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eUJjYtNr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5DBC147;
	Tue, 17 Jun 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750119979; cv=none; b=TpC1PHSaw/A7EYw/1PDaio62pzlYYr4fevQDd9k4Pm8DgplMX1SwIAF32o2K+gulA7Px+fjSGHIgHxTvsm2fodC/ouLder9OEQTczlxVjsEAyHeQ+XVtTdeku744bI3HQSLN6x6qX5zYSP1g9n6cD4ALbAf8vXclLbKgLW1rTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750119979; c=relaxed/simple;
	bh=1dNJ+Ka9TAbVHyjR2CGsnLlmTs2kKI7Ua3GjWXy7N04=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CJSlmVKTcRi59dF3n5jWve5Yc38zc3sw8mM02Y8XCnUsQE9AvORxLpH9f1gMvx+5rBKMvas7+uZuKNsMlMSdYDWgD8Zui08lzEiCkDcLlLYfp1od2Nte/vYeC/zKw6OAboN8Tjm96sJwjzPridoCGSmuNkf2p+W40hRRquyY1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eUJjYtNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0C6C4CEED;
	Tue, 17 Jun 2025 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750119978;
	bh=1dNJ+Ka9TAbVHyjR2CGsnLlmTs2kKI7Ua3GjWXy7N04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eUJjYtNrlIBLqlVTJPk1mF/8PxhL3dnyjjgMetEL0b1iJhpvSaz4fDhoBdhuWDCXv
	 F+HoxcdRNNdsUibp3ZyVi1+dg5Syv3skVvg7xTm2AQvwMOXtInY+yREkkxJ7Wlq2XV
	 xR/OXyVVMPAAX7LBcmRuI0EM1sByMfKc4be/8YlA=
Date: Mon, 16 Jun 2025 17:26:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: shuah@kernel.org, peterx@redhat.com, jackmanb@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v5 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-Id: <20250616172618.0609127a8b1e406d4c228d24@linux-foundation.org>
In-Reply-To: <20250616100406.2853-1-ujwal.kundur@gmail.com>
References: <20250501163827.2598-1-ujwal.kundur@gmail.com>
	<20250616100406.2853-1-ujwal.kundur@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 15:34:06 +0530 Ujwal Kundur <ujwal.kundur@gmail.com> wrote:

> Refactor macros and non-composite global variable definitions into a
> struct that is defined at the start of a test and is passed around
> instead of relying on global vars.

Well I guess that's nicer.

>  5 files changed, 616 insertions(+), 542 deletions(-)

It needs to be!

Thanks, I'll queue it for testing while Peter thinks about it :)

