Return-Path: <linux-kselftest+bounces-41441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4800B56217
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD4E1B24E45
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947362F1FCF;
	Sat, 13 Sep 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh3Qhtu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240F2F0663;
	Sat, 13 Sep 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778978; cv=none; b=OjgYGDMBKmfoqMMj+LyyiSJ0y0PNH2VmQrMokCHh3lEttYsShtrkkY3h4dnp3tgVuCuB0jndPJNjXpWtIs9ovdMqlm/toQQLBaxow94rH9hKpJWpEfKFN3sVqLvFOEXXRyQZAO8uVVaXNhBhrWi4Eumfx93VwlOZXP9HZTgsgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778978; c=relaxed/simple;
	bh=EqbGHHh1daWA63zulWQNxuwItilk7j6agw+n5QVmMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiKDkIWd2+WdOm4skdApCt7nq8XtbJbjvZRgPBmM26YLnC7x3+rFqK2GoxZaI9pLEFFhH7bZbWDEaeY+MNjnWkWwB74jvzQ0dhcvLjYqo9CMFk6il4gm5w7w9DbbX9I3vBIzDPbq/xJYDUH5s5T0bBSh0klGtquChKLggK3cGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh3Qhtu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8444FC4CEEB;
	Sat, 13 Sep 2025 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757778977;
	bh=EqbGHHh1daWA63zulWQNxuwItilk7j6agw+n5QVmMy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gh3Qhtu5BWVfaWlCcgNLe7GT/ghSz3nDSsPBjRW2AvchXr9iOTCS+T4WYm8nNC6B1
	 3LUF+WOaW5gpVPkGjdBBkKCMNJS2YhZkLWyXBjagf1prh9/Zq50BrirKWEgarGYc+3
	 9IeBOnelyjIfz2sf8yWKo53gOYdOrVHHxGtR4COANei0lWkTaVk2WBCDyEVEj3H762
	 EEK6mvwrmlPD6XkBN/kB/DQ5EQq2r+ZUH7UOjgXXC1ZbJNKchg4zK8nKU3Tp55O/4H
	 /Orjz05skUQ5UAVKjq86HoCzgHcny3KCgixRKTG3Ch4xhO171f5uw/Yb26U7T3cpe7
	 yFXAU2WE9w+iA==
Date: Sat, 13 Sep 2025 23:56:12 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] revocable: Revocable resource management
Message-ID: <aMWUHNyZ_Y3XYyuU@tzungbi-laptop>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
 <20250912081718.3827390-2-tzungbi@kernel.org>
 <87v7lnn6m9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7lnn6m9.fsf@trenco.lwn.net>

On Fri, Sep 12, 2025 at 07:27:26AM -0600, Jonathan Corbet wrote:
> There is a certain amount of duplication here, stuff that might go out
> of sync at some point.  I would consider pushing the bulk of the
> information into the kerneldoc comments, then actually *using* those
> comments in the .rst file (with kernel-doc directives) to create the
> rendered version.

Ack, will fix it in the next version.

