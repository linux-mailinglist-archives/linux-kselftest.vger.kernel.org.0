Return-Path: <linux-kselftest+bounces-24426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052FBA0FFE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 05:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BD93A7072
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 04:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BCE230D05;
	Tue, 14 Jan 2025 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hwooaxNo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAB168DA;
	Tue, 14 Jan 2025 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736828033; cv=none; b=iTL7T1uRl1K4ON2KFEsuvD4Y18MUciLC8Z2bo+S7aZPvjPa1It4amsVepCckDJ0vz11SExaKS4/9Yq304Bt5xJLpOmnXuC7wOPACf69AtAnLaNc8jrxbGuTzmVdgDqs+kFoRfrF7DdNt8js9OKFWsrT9LSiZVq4WC0Z6HdjLsFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736828033; c=relaxed/simple;
	bh=npt1zzpa5Ty3PI1YE30Yf4hhmi2a/mYSDGnhNJH/M9A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Qemib7+YCgRaIJ68xiIqVnC15S1Pyy/ZVyPI1Z1UhSLCDWYpn/gUtEBVLYht7qe3mztp4YEyz3nhEvFOpmE6zmGhIGNv+Kh/Pl5J0/4mNw+BfMToOAmR0C3VS4BN3ko9RDvMGRWnKGj9Qne6UOfU+NiU40+1MuYzUcJAbp9ZEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hwooaxNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DFAC4CEDF;
	Tue, 14 Jan 2025 04:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736828032;
	bh=npt1zzpa5Ty3PI1YE30Yf4hhmi2a/mYSDGnhNJH/M9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hwooaxNoAI7aSEDirVT8kE44k16/MlQcuHScTFz15EsC1gu0u5O0ajoyfhGGUcp8h
	 maPBFKMShe+B1FXAxaYYoUOPi5ZbtntotBFWekqAx6TbAq8qtpfeh9cCVkq5w3piF4
	 Ut5nEL+7MvMmBQvQrWWbW76lvk9jkUp0Tf4rHD/A=
Date: Mon, 13 Jan 2025 20:13:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: liuye <liuye@kylinos.cn>
Cc: shuah@kernel.org, jeffxu@google.com, isaacmanjarres@google.com,
 lorenzo.stoakes@oracle.com, gthelen@google.com, sauravshah.31@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/memfd/memfd_test: Fix possible NULL pointer
 dereference
Message-Id: <20250113201351.3f48cc86f06a7dc01d497872@linux-foundation.org>
In-Reply-To: <20250114032115.58638-1-liuye@kylinos.cn>
References: <20250114032115.58638-1-liuye@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 11:21:15 +0800 liuye <liuye@kylinos.cn> wrote:

>     If name is NULL, a NULL pointer may be accessed in printf.
> 
> ...
>
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -171,7 +171,7 @@ static void mfd_fail_new(const char *name, unsigned int flags)
>  	r = sys_memfd_create(name, flags);
>  	if (r >= 0) {
>  		printf("memfd_create(\"%s\", %u) succeeded, but failure expected\n",
> -		       name, flags);
> +		       name ? name : "NULL", flags);
>  		close(r);
>  		abort();

Well huh.  I though printf() would emit "(null)" in this situation, but
my super-sophisticated test case says "core dumped".

#include <stdio.h>
#include <stdlib.h>

int main()
{
	printf("%s\n", (char *)0);
	exit(0);
}


