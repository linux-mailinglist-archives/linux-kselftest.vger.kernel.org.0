Return-Path: <linux-kselftest+bounces-15343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE7D9520ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098BC1F24183
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29541BBBD1;
	Wed, 14 Aug 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyOrKVu1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87C1BB6B8;
	Wed, 14 Aug 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655889; cv=none; b=IFJy00Lgk5zBfmItNDyUAkHINp9r+s67nJj0dSzAQb+4pa2rLV7Qw7CipacIAMBTZNjq+GNjRDT811aGhAlq61+UZfndOuUOyGC/KOo52Gsev3wLwpEuMZTzFVCeiLSj8uEYG6qqPeG3eoeBuYDmdzHkqeTx1GgUF6OtpD8JpfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655889; c=relaxed/simple;
	bh=HxlRhzk1Ob/LiT8iJm67CmU6Xj5N9LEAoLVSK1YCj1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjg+Z/08QW5No+cFHuPrMMfJ4+MWcDiGHyk6e8Kqyhb218NFzUqNONzJxtVjauL185arK9DPAIdSMiKh+ZnPr05UWDtlSR0ADTd4/UsL6GoglXz+beLYqjXN/nw3QcCfUh8SAsMs2D54ouixGxddEHUMcUkC0uAOV4DyZqj+rBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyOrKVu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804FDC116B1;
	Wed, 14 Aug 2024 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723655889;
	bh=HxlRhzk1Ob/LiT8iJm67CmU6Xj5N9LEAoLVSK1YCj1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OyOrKVu1Cjc4kTEy4uyKTsK83WCfe+AmUf3bp5ShhcJRurp0LYXOCmushoZQHwvd4
	 gbD5FHKLYgx6wtqaQOtH3Bl2noO7aDqR/CZBUjCyd+rwWBLvc4ojNtdf+8QmzXl/9Z
	 PoENmCHBCsJOg8UIC9LeSSwp9Un5yct/70HOMbZK/8Z5YWupiH+bko6EMt4D63bdW6
	 C6p+0TR+0E9lz1ICAi5dZ24G6+X25C9mXcSca1NMQUo19QW5m9ze/zcM8qgJAuwYl7
	 FwNmvjsCjwn/SlQbelYL3nXU2bj2G5wT5HWSHaYJTJsACLRcP6M2OmqWMuK7WwF2W7
	 jrgpXrOUQ0MhQ==
Date: Wed, 14 Aug 2024 10:18:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org
Subject: Re: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
Message-ID: <20240814101808.4409c4b7@kernel.org>
In-Reply-To: <20240814171403.32374-1-abhashkumarjha123@gmail.com>
References: <20240814171403.32374-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 22:44:03 +0530 Abhash Jha wrote:
> The word 'expected' was spelled as 'exepcted'.
> Fixed the typo in this patch.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>

Missing cc: netdev@ please repost

