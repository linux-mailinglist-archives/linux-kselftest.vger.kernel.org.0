Return-Path: <linux-kselftest+bounces-6473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB08862BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 22:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75AFB224C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55206136650;
	Thu, 21 Mar 2024 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CgSdgBUB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110FC85265;
	Thu, 21 Mar 2024 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057908; cv=none; b=VbHE6eM7X/kV26TEgbPai7FylYxgPHSWPpHzKiURe/O9+ioBMTBl2a9ir3oSYlsSO+lPZ7APeXUHEzIei7YVYte+P6fvShENvtX/ZriXeBblJyhIKKEs0VrO5+56yLV4uBoR30nNOVebUILa0lDo0x4xw4HRxbVMvHWRIaKrw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057908; c=relaxed/simple;
	bh=PFlFbtJo/tyI5/55AxDQL37wAmCPfeAfkLdS3jv8iE8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cGmNaBExeCn4mrKR/FwWekpowQo4xSHKllcrYxV3f931zJb5hVAJtR91r4F54yTScUhNCQLz7O0cnVGipq7kXWZgwPTdNyBi71vAo7Tyh9gc6WAvnlIl6+aG28c9l406xmTFPF7wL8IfSU0JITvaLY6LwZ2h0DOP0VSb0tyf9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CgSdgBUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBB6C433F1;
	Thu, 21 Mar 2024 21:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711057907;
	bh=PFlFbtJo/tyI5/55AxDQL37wAmCPfeAfkLdS3jv8iE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CgSdgBUBFiDt3okUqvtkGMIEYDUqXbwvZ/kjzwcVxkwFMwp8MUfX5FM+8aDwEAmE+
	 Mg8xwbKCQs/+Mt2df3CjIm90aQzLHuP+nRcvCA1T4uCofIcr6/zQCX7rXRk60R8TUM
	 qh8AelK31eg/QzpxOhA7yTIwKhOTdv5SBLf/86YI=
Date: Thu, 21 Mar 2024 14:51:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
Subject: Re: [PATCH] selftests/mm: Confirm VA exhaustion without reliance on
 correctness of mmap()
Message-Id: <20240321145146.a3ce8a1e247371e33a437978@linux-foundation.org>
In-Reply-To: <20240321103522.516097-1-dev.jain@arm.com>
References: <20240321103522.516097-1-dev.jain@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 16:05:22 +0530 Dev Jain <dev.jain@arm.com> wrote:

> Currently, VA exhaustion is being checked by passing a hint to mmap() and
> expecting it to fail. This patch makes a stricter test by successful write()
> calls from /proc/self/maps to a dump file, confirming that a free chunk is
> indeed not available.

What's wrong with the current approach?

