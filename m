Return-Path: <linux-kselftest+bounces-5955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322918728B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 21:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E281F217D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 20:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D212AAE3;
	Tue,  5 Mar 2024 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE5K1wUo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05225129A66;
	Tue,  5 Mar 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670357; cv=none; b=i69wDo/x89gvdSMNJfadyaSUXl8l/ag7iF19VhP6d5NoqcYsakgKr9J9PlYOXiaiA5/8EicwUhdd6cNGLsO9Wcw2zF542fRlfFneJ6xLsGHKJRsXAPC0RiPVLk64Vt/Pp+Yos8r4nIdv4J37hadpyia5yoM8IHfz0vGHEF+lAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670357; c=relaxed/simple;
	bh=twGZuSpW/OlwcJKaoJzLeolSrwNRJlzj3LP+VjhWkZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mN7SDKrjmfcO48GlM10dlS1+76P7WAau0DG+txUNhl2uEB0YUDZFVR8EuIxK4ZBBB+J2qCEilVEnGc3t9T+7RwGBdTxuvQJxHftiXWO6/Gg4nv7LRZ5l9RwlO6mNakwREh9exNu9Zakd/QE41DFy6KVDVPN/lLYBu/oqOtIuNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE5K1wUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3211C433F1;
	Tue,  5 Mar 2024 20:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709670356;
	bh=twGZuSpW/OlwcJKaoJzLeolSrwNRJlzj3LP+VjhWkZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qE5K1wUo76qnPiNlHLxTKGyEbTtDi6YvsKz9JozKv9o0F72ivEAjamCWq5tfLUQqS
	 vHixmexOppZ+XDz3WS/SJEJy+QLABp+mUV0Xi3EykX3J6LIqcwMam3RaNTqJ0qW/R3
	 IDuaNv/qt005XnpCdNYOSF/CIDcBqMKd/9FdIsx/8jDZvfk66ch80y68qLgPrbBf6e
	 d66roe1k5G3kHlaApnPG94m1hLQ+s7/Xunuy7Yq5IVL6imS6V1qxA4tH3higv15GIC
	 5McCBJ7AdSAr7owcU0YJxo3VtPyz84q/FQxnvddkLttJgHszjoJxrIklyyguy+nEW8
	 rdPDtZKkA/yXA==
Date: Tue, 5 Mar 2024 12:25:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: "David S . Miller" <davem@davemloft.net>, Kees Cook
 <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, Shuah Khan
 <shuah@kernel.org>, =?UTF-8?B?R8O8bnRoZXI=?= Noack <gnoack@google.com>,
 Will Drewry <wad@chromium.org>, edumazet@google.com, jakub@cloudflare.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/harness: Fix TEST_F()'s vfork handling
Message-ID: <20240305122554.1e42c423@kernel.org>
In-Reply-To: <20240305201029.1331333-1-mic@digikod.net>
References: <20240305.sheeF9yain1O@digikod.net>
	<20240305201029.1331333-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  5 Mar 2024 21:10:29 +0100 Micka=C3=ABl Sala=C3=BCn wrote:
> Always run fixture setup in the grandchild process, and by default also
> run the teardown in the same process.  However, this change makes it
> possible to run the teardown in a parent process when
> _metadata->teardown_parent is set to true (e.g. in fixture setup).
>=20
> Fix TEST_SIGNAL() by forwarding grandchild's signal to its parent.  Fix
> seccomp tests by running the test setup in the parent of the test
> thread, as expected by the related test code.  Fix Landlock tests by
> waiting for the grandchild before processing _metadata.
>=20
> Use of exit(3) in tests should be OK because the environment in which
> the vfork(2) call happen is already dedicated to the running test (with
> flushed stdio, setpgrp() call), see __run_test() and the call to fork(2)
> just before running the setup/test/teardown.  Even if the test
> configures its own exit handlers, they will not be run by the parent
> because it never calls exit(3), and the test function either ends with a
> call to _exit(2) or a signal.
>=20
> Cc: David S. Miller <davem@davemloft.net>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F(=
)")
> Link: https://lore.kernel.org/r/20240305201029.1331333-1-mic@digikod.net

Your S-o-b is missing. Should be enough if you responded with it.

Code LGTM, thanks!

