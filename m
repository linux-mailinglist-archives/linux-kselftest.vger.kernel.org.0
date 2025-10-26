Return-Path: <linux-kselftest+bounces-44073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D9C0AE3A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 17:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C815E3A83F1
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7EF225760;
	Sun, 26 Oct 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lwK/j3jk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D492AEE1;
	Sun, 26 Oct 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761497227; cv=none; b=qvfGYy5Yw7GfEUv27FYCotx1wTI49EldQWjsR8QoyKRHWmyUSui6Ohro9tn+j14u2bZKg+A6Mq7e2rV/cIPc2OIn14TLl1RjU4LX/tFUihxTCchhDZbkkJMh6kdN5XWsTMTKcGZeT+LLjqky8f50/kIWJTgdlYfAaQXqPlA9ZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761497227; c=relaxed/simple;
	bh=TQUwPvAkHJ2nZzLT1uTkFxreINBWmtgUebt9cW1T8K0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dUvnLjk4ZTlWXetLXi73QepdhWieFYy3Zjoust90OVQtPtSKP9CgdOuERfVtdFJ0IR0kfw2uisZ4WMYQQRp2QRNNf8aebGzRCqKf4vTUdMexMfonc6XM9F9Uoln5ym8LdZI41jnoerJz1rX+9HY9SS9baFUXQjXVz321sMK0N0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lwK/j3jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D4BC4CEE7;
	Sun, 26 Oct 2025 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761497227;
	bh=TQUwPvAkHJ2nZzLT1uTkFxreINBWmtgUebt9cW1T8K0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lwK/j3jk9nAj/uSS0svWYrkZXKa5Bi4EumIBenDd8s6o2tUouNTzmheD3OznDubIw
	 rkx+Uu50J/RVI9wHGr9Ybi5zvZddSKIXWHORmdnNiS9HaLQx5xYUI2OWy6ZE+R8D0l
	 SMe/Sy1ozlZp2lGgHsU2kZImFFbqZgiAqvIAd0p4=
Date: Sun, 26 Oct 2025 09:47:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, brauner@kernel.org,
 corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
 pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCH v8 7/8] liveupdate: kho: move kho debugfs directory to
 liveupdate
Message-Id: <20251026094705.c62e10042c0e4e8b093995be@linux-foundation.org>
In-Reply-To: <aP5NLJoSfKTVnsQV@kernel.org>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
	<20251024161002.747372-8-pasha.tatashin@soleen.com>
	<aP5NLJoSfKTVnsQV@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Oct 2025 18:32:44 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> @Andrew, please drop this patch for now.

Thanks, I dropped the v8 series.

