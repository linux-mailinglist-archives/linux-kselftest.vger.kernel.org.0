Return-Path: <linux-kselftest+bounces-48533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DADBD04291
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5FF131ABDEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D041E98EF;
	Thu,  8 Jan 2026 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHfmf0Qa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB801DE3B5
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886973; cv=none; b=MePuc0c+VUOnvuD1OS8czVQNicbezH5oQwRfX/3XLEOk/tsfi71FWey00qdlQokKJSHP/WMtSwvVdmb2lTRpn9S21+SjU1BlZEJUyMG9Cs9DRAl5EjGUcNjLvciM04dbZx9/bwTc03/I+doG9S4qvkAWybAr33+UMUApsM6bVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886973; c=relaxed/simple;
	bh=g+d6EAF+jEni92k0wW1XD6xAlIV9Ui78ossX5Z7tAl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feZLY3m0/1j9XYoEmfJw2Fk3AuEm7Or9q9kx0yEsLntnTQR3OgiC/766nQ3cqmR2JijHja/u5Bt2CbTG/jm5+zydlVbXb5wMa7g8sjsw5JRmHAg0bMHBuJwPzwXCi61sbxON9OqbjIhc44/kHxLhtXFO+2j/Y2pjFkF50TNIBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHfmf0Qa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a3e76d0f64so9291005ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 07:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767886972; x=1768491772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbJF7mAe3Gtgg4xboSqF3jM/kOEzl6cEvHxPfOpVHqs=;
        b=aHfmf0Qa6jVQDVJbkPU7//FYTrT3y0cOPOewRJgGTtuXvSgVcKv9ncR8UNYpBoPU8H
         sLuslWiKENKsAtcxUL2C8z5/RcRY37zncg1FO6T3b27qAxxvscG4uVV87RAvaqf6YKSq
         fYE+XXn6cbx5d8byAoujJ2jhorArZw5PloebQkX3qQjLgeEwWROcNg9ai3c2LG08kBdm
         LmN3k52JBVGvEzPIszqIyBr95q6G7q/IcENvVg5I7Tz5eds0IMMC22wOnZO6VxyRwfhZ
         0MtGab3muS7Mjfz5fxXMdvfON5MWXoTfewXxyrcz0HUX82f/GHvmDOKgOAGNZwKcSGTA
         27qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767886972; x=1768491772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbJF7mAe3Gtgg4xboSqF3jM/kOEzl6cEvHxPfOpVHqs=;
        b=SNM6VOP43EYob/l1gJb23wcbGE8+K2dbcv1vB31qS33pLyO5FHqOiOGE09oYBzvzEL
         2Azo9hFchXeTfvuq+qngsE1BDjlMIcY0NwI/gt22WqhCnWw+K4FOB1fjRSqbqvkPvtmS
         EqFWoBHl2iJW+amggsceng714g8XSoYmBZdqLtKvNhkoJJrqGXLW0O83x3oTTvMuLaJZ
         qjnBXNEy091WuisDWJsTg/4pg0bB/LVOdnYWUA9MvP0RMpxlsaSVD7zP5pKYk1Rpxx9C
         VL68TSRe/3RRzycZ/G2FXUUkkLj8EwWL+53QYWir32PRoOFRQU8LySYt4VzqKRAoFU5I
         wQbg==
X-Forwarded-Encrypted: i=1; AJvYcCVriX6OzSNQruGTCyPs5euMQRLzCuW5AUCJ0W4ZGqqAj5/ZSwgRpJuwLfd1WELcVVngMcbJV+JlEK/RQgfr6b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsLlDqfxlgZ3ZSkBy5NkhTIZXx64Y18KoUv8QF+CISyVIZxGV
	Jv6HN99W7ELTuWeXK7vqk7VXb5vKCvPNhpbo57e1XuEVu+tqhCPNF1XX
X-Gm-Gg: AY/fxX7ZN1Zlg7jMR7OT481YyHa2aVGwqp3FFLjtxNlsddtfKCvLh8tDB+8zHvKJX8w
	VnNlSeDVP0Bcgf/12KszvMU1PXlYVeiPk5rszevTpD8bXJpnNv+0IQ3iJPOEaVl4ClUwWzj1TCY
	0Yie9Ug+YQ98rEcxDG9NB7VqxYlqFND41IvbyCXRdHJOYCJoFvz+7u5Gu/kWBYiWQN+BVLOmPaT
	RPBKqpi7aXZJMmsSRp4a0cKvUzKiaLXOQu13SeCf+K39d4q4oAAybk/OjDdqwhEliqvqCx/G5B/
	yZaUxSMKRlTj+1hYNju7mNc8Icoa9DkeIEaYpAO4vNCoRcRBx7htZe8/hEnYRSmCDdaJJ+8NAAz
	X6vn8Sk3JT+/S7W/xfAdJ4CwPzEN3i+5p4RgqCcXNCFR/Js+QD8SF4ROThIsXNJ3Fwz2QdwfY68
	72GBQ1iJ5uKnszWmQjhE9rnCb6
X-Google-Smtp-Source: AGHT+IH7/w0W9bkGI4njgtLzcbVZBbLTOIf1Mg2i2c9sF3zkMGAxBoeI01K12PWP17Lbv+KYdYV3lw==
X-Received: by 2002:a17:903:388d:b0:2a3:ccf5:6691 with SMTP id d9443c01a7336-2a3edbbbb15mr76932475ad.30.1767886971822;
        Thu, 08 Jan 2026 07:42:51 -0800 (PST)
Received: from google.com ([2402:7500:577:2fcc:7f59:4ddd:9265:c9c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88cdsm82311515ad.73.2026.01.08.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 07:42:51 -0800 (PST)
Date: Thu, 8 Jan 2026 23:42:47 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Kir Chou <note351@hotmail.com>
Cc: akpm@linux-foundation.org, geert@linux-m68k.org,
	linux-kernel@vger.kernel.org, davidgow@google.com,
	brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, kirchou@google.com
Subject: Re: [PATCH v4] lib/glob: convert selftest to KUnit
Message-ID: <aV_Qd1bKb8hNqfYA@google.com>
References: <20260108120753.27339-1-note351@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108120753.27339-1-note351@hotmail.com>

On Thu, Jan 08, 2026 at 09:07:53PM +0900, Kir Chou wrote:
> This patch converts the existing glob selftest (lib/globtest.c) to use
> the KUnit framework (lib/tests/glob_kunit.c).
> 
> The new test:
> 
> - Migrates all 64 test cases from the original test to the KUnit suite.
> - Removes the custom 'verbose' module parameter as KUnit handles logging.
> - Updates Kconfig.debug and Makefile to support the new KUnit test.
> - Updates Kconfig and Makefile to remove the original selftest.
> - Updates GLOB_SELFTEST to GLOB_KUNIT_TEST for arch/m68k/configs.
> 
> This commit is verified by `./tools/testing/kunit/kunit.py run`
> with the .kunit/.kunitconfig:
> 
> ```
> CONFIG_KUNIT=y
> CONFIG_GLOB_KUNIT_TEST=y
> ```
> 
> Signed-off-by: Kir Chou <note351@hotmail.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

