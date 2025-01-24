Return-Path: <linux-kselftest+bounces-25123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A9A1BAA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7FC188F942
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72539199244;
	Fri, 24 Jan 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZoA4xlX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1BF15A84E;
	Fri, 24 Jan 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736672; cv=none; b=mPgQ0O1qvyjGEPIqOAVXHqsy+YZFzhrw7sWZhtqdlafZsS/AtBkDeDxYI20JFpzBlwa7mnIYcuFYxvNa47m9vYhLKwpakkiA3mh+6DkmJ4l2KXXlaWPenpMjO77LO1UOgF6u1cRnSrtGIdNagDYTQXmOagfxpq9ttDYKlZQ04Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736672; c=relaxed/simple;
	bh=rcDAbKpfeo1T9JVPf/2Vk+EX8vgku4pmHZ3kLc/+TLE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=pg14YcixPgDUXEZVumqteUjl9UQJHZvc0hUgQ6QJVJTs/CIvXM5YmRAJkE0wwrfM6ktwZjswbLCECIqwYa1PlNFtLNk6AS7DhXqxc/e8xkTb1aXwLVoANuYe0rvQ58nzRSdBITmWk9bsOgcfPVcQtofaYr0JFxlLbTDE7rZLKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZoA4xlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6E3C4CED2;
	Fri, 24 Jan 2025 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737736672;
	bh=rcDAbKpfeo1T9JVPf/2Vk+EX8vgku4pmHZ3kLc/+TLE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=VZoA4xlXkMvTc3LUAilJb+yvAO9KbOC8+6lh+EjkWMEx3WBsx0WVnC7lfRA+KB2TD
	 +mm7qcV+txgY/Nmn5DkHK0ZFZMgbtyio2vVxG9y0ZLa5rF+6bNriNmxx9U+CZvx/IZ
	 eerXzV7PuRvjP+WKAqC078CYBnBycwZ4tDI1K2LQsQmYTpLktcA4AW45h9paMUnot8
	 eKM4aWQemUF+qOcFiAImN9KCtXTgjtBxJ3bSdOhrFlY98b7XMsUcUdAdY+qTNGeXuE
	 1dx1r+Ez1vrtaU5WjdZVwrycB028Sfg1s95RoYnYrt8AMzVdekYFbePHg9Za366A1Q
	 gR1yrgBt68YIg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 18:37:47 +0200
Message-Id: <D7AG8K6T8KRI.LZFD4J6OFGGZ@kernel.org>
Subject: Re: [PATCH v2] selftests: tpm2: create a dedicated .gitignore
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Khaled Elnaggar" <khaledelnaggarlinux@gmail.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <shuah@kernel.org>
Cc: <linux-kernel-mentees@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20250122065021.91814-1-khaledelnaggarlinux@gmail.com>
 <D79CVJJBY9KX.23K6C7S5BU8AV@kernel.org>
 <d7c0995d-5159-47a8-9193-d9d29fdfeea0@gmail.com>
In-Reply-To: <d7c0995d-5159-47a8-9193-d9d29fdfeea0@gmail.com>

On Fri Jan 24, 2025 at 4:35 PM EET, Khaled Elnaggar wrote:
> On 1/23/25 11:47 AM, Jarkko Sakkinen wrote:=20
> > Why?
>
> Sorry I should have included v1 in the thread but I am still
> new to the LKML process.

No worries, relax, it was just  a one wonder question :-)

>
> Basically tpm2 selftests have 2 leftover log files after running
> (namely AsyncTest.log and SpaceTest.log). Only SpaceTest.log
> is in selftests/.gitignore while AsyncTest.log appears untracked
> with git status.
>
> To solve this, one could either append AsyncTest.log to=20
> selftests/.gitignore or create a dedicated .gitignore for=20
> the tpm2 subsystem tests. The 2nd approach is better in order
> to not clutter selftests/.gitignore and keep tpm2 isolated.
>
> Shuah actually suggested the 2nd approach in reply to v1.
>
> Would you like me to resubmit this patch with a clearer message?
> Or include v1 in the thread?

Yep, please do, your rationale makes sense, just write it down
to the commit message, and that's all I'm asking for.

>
> Thanks
> Khaled

BR, Jarkko

