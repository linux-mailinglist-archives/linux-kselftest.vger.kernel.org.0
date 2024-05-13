Return-Path: <linux-kselftest+bounces-10137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0188C3FB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 13:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4421C2264B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4814B95F;
	Mon, 13 May 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3t6313W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304DB146A8B;
	Mon, 13 May 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599257; cv=none; b=rmpdqgLAGzuc0VYkoOJOlS1kjfBJba6b3xCvYDwupVChso7eux8NM6Wrj5Yyb1k0/E18aeBgR6X/Ndj5y7JrJo9ooIDOTYx+OyoqktQHOge+YPfGJmTCB8uOpZzb2vgQM58i0mjX+bCL/MNGNmTL0/+1B+QRtC98+BjeJfdEvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599257; c=relaxed/simple;
	bh=hw1Avy7nsYq8cVMtiw3gPkQtVbSohz1j4cVpsZOqgIs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XP6N0dVso4R+gMj7lSpJ3DwAkIhhOC9uHTPacHngPd9sE/K55S1/L2YbGMWZka3uu6BjwKvgSNkp9QP6ggkroWb4MQrQAwl3v7Pt3O8Z2crZQ26blneFDtToBnTknhmMFR6Dc9rZt6rZZTWBxH7Ome4pmbseV7kUw655VY3vX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3t6313W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C59C113CC;
	Mon, 13 May 2024 11:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715599256;
	bh=hw1Avy7nsYq8cVMtiw3gPkQtVbSohz1j4cVpsZOqgIs=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=p3t6313WcjtyLf/NsMYbc1rS89GKhat2IUaj+VgvEJcsHgLZxslIAbI7u4rRuxy8S
	 lyAdVowC2z6Adx/mJo+M9HNB2il7lYsTt93K8cnrvQNF/JGdZ6jFlNGe7EEbywwdfZ
	 KnxHJ5njaa9EbUVRzmZs9YT0IQSugsMrRT1lZ3fNIzfBqz4oWKcq5cKUwEfDaBpsb6
	 eeQnmi1kkSBSpH5ugVe9LmdvZr/Z0wePpUWoOGdUV30SLB6Ch7yb1IroEV/tzn/rae
	 5Sgd+LRAGvw9m1p7u2pag5cP/eMSYva3oss9XzUiygbjX0N/y7ELbjOU1uPVYQLi5d
	 x4QJExEtIWimw==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 May 2024 14:20:52 +0300
Message-Id: <D18H6GHC4VSW.3C39QY6XUDOQR@kernel.org>
To: "Mirsad Todorovac" <mtodorovac69@gmail.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, <linux-kselftest@vger.kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, "Shuah Khan"
 <shuah@kernel.org>, <linux-sgx@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Edward Liaw" <edliaw@google.com>
Subject: Re: [PATCH v1 1/1] selftests/sgx: Fix the implicit declaration of
 asprintf() compiler error
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>
 <4dcd5fca-c200-42d1-a8f2-3045d5430fd6@nvidia.com>
 <65a79654-90e8-42b9-a840-e2ef404fe1f2@gmail.com>
 <D181GV24ULEA.UWQHOSM80TEV@kernel.org>
 <CAJ3WTWRQcZN5JSNAhUKXfpH8Q5sW_-EorMpgCE24G3NpczpqZQ@mail.gmail.com>
In-Reply-To: <CAJ3WTWRQcZN5JSNAhUKXfpH8Q5sW_-EorMpgCE24G3NpczpqZQ@mail.gmail.com>

On Mon May 13, 2024 at 12:43 PM EEST, Mirsad Todorovac wrote:
> Thanks for your explanation.
>
> I did not realise that __USE_GNU is evil. :-/

It's not "evil" IMHO. It is not just part of defined API :-)

Thus the official man pages are your friend.

>
> FWIW, there is a sound explanation of the difference between
> _GNU_SOURCE and __USE_GNU
> here: https://stackoverflow.com/questions/7296963/gnu-source-and-use-gnu
>
> Thanks,
> Mirsad

BR, Jarkko

