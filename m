Return-Path: <linux-kselftest+bounces-12176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA4290DEB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 23:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8791BB20FCA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 21:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A290B1779A5;
	Tue, 18 Jun 2024 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kwb5zCmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D786482DA;
	Tue, 18 Jun 2024 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747630; cv=none; b=FzdTyk3KxVQSRQrphSbsHEyajUEzXafFqkYNt+1dcTynYJxLnifIVvWhJRtY8NjsC78aRy3KjxYwHMuE076XX6ZtxjCe0QNbhotCzdQHPahhco46dNUjNWxgAE9r6XsZtSEV9u01KEc52YFQlLpp0Sf7WLaEDPvSMhGd5b61gwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747630; c=relaxed/simple;
	bh=CYSvvFFsXDN1ydp4uZ6fCMUrSraHtaWKy72P4Pc7IhU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Y0Lcj70NyxAo4IlXp4JY5tPlehhOTU2mhZjSmXQ5ycqjzQvt/FQgPzjZsHJplFhymg5HAaOsetBbYPic4KiHUTT9InpBzeOJa4XrReFjUy/E2PztTYEoFhTaDUJYzqnbUsScjxEHCNze5gM7xmYpH1mSBVILqLzvikqIFNcJm7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kwb5zCmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B642C3277B;
	Tue, 18 Jun 2024 21:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718747629;
	bh=CYSvvFFsXDN1ydp4uZ6fCMUrSraHtaWKy72P4Pc7IhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kwb5zCmjwZZOmylxm4bY/Sdb9BrjRDII6/F73UOVeKZLK6RZRDy2F3Gutby9a55Ph
	 Z4qjZoZk8UYg/FkDcVmcImaa2DfgLTltO/R/viUuI5/L2TByxojuP3tw1tUDa9OEqN
	 tHyVSt9VuhqJ1bipJes3grTjxilEG5nTi1O7dKQk=
Date: Tue, 18 Jun 2024 14:53:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@google.com>, Axel
 Rasmussen <axelrasmussen@google.com>, Christian Brauner
 <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu
 <peterx@redhat.com>, Rich Felker <dalias@libc.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] selftests/mm: mseal, self_elf: fix missing
 __NR_mseal
Message-Id: <20240618145348.d49c130694dcde29ec7a6c8e@linux-foundation.org>
In-Reply-To: <ee207aed-d116-49b4-a5cc-91385c52e258@nvidia.com>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
	<20240618022422.804305-2-jhubbard@nvidia.com>
	<0b152bea-ccb6-403e-9c57-08ed5e828135@redhat.com>
	<9d08f768-b9da-4a44-9d75-a16d6cde6b66@nvidia.com>
	<916f5ba4-02c4-4a33-97e1-5343bde5ae54@redhat.com>
	<ee207aed-d116-49b4-a5cc-91385c52e258@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:29:32 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> OK, I've drafted an updated commit description (below)

<copy><paste>

