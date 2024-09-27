Return-Path: <linux-kselftest+bounces-18440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2FE987D89
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 06:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E4E2842C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 04:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D316172BCE;
	Fri, 27 Sep 2024 04:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qur09JOl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5B2AE84;
	Fri, 27 Sep 2024 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727410453; cv=none; b=bjyV9bmjq9ERUsHqeRNPyIeSA+Ukrg1u7jZa0BxyPl1G6S0OhPcrMuPka4uKJKhnOp4aEx8EoGifVoJZGujwt0q5eaDV2tm/yAKRV0fvSTe6HszfA5IT8yvh9gETcV8S1zDxP7cG6jv+s+iLSb3iIy4j7xd2JR/CC49CLzulPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727410453; c=relaxed/simple;
	bh=JVL2fUPhe7PhfPh2yglWF3nfspxFiAyHvNIEuOzsF4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE04jW3FGvpLXcO40vPcc42nMqSstjl9XUQbC1/MNBjRf6JnElYIpMiqMhzPE/KPF5lWamkcMPRF3++m76t59WiTyWE0zE8iM64KFrBE9lQLglsA2o/1fSx4D0cgqdEHO1+wCfpckE/Vp7alMvaM3TJRDX9hgB4m6yul/BJenMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qur09JOl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206aee4073cso17849155ad.1;
        Thu, 26 Sep 2024 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727410451; x=1728015251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmPC7xOEq4xiQYbTsTCCja7E17GlGBjk59a6Y6qmbow=;
        b=Qur09JOlkHbBXshLpChKTSxuQZSAykBrwObI3ikF2+MvvZELFM4eGQgtUk3wXoWpwW
         KLCoGrj/1fEQCr89g+5wJoq2X7CtWPlUT1qeW6AC7JImyf9SpeIhrUEVbAWdW7wi5znd
         9LjVZbhWquXcGdZUJandrFfN9yuag35g9nYe8h59pGnKrqql21uILunwxZ6nrfrwLhht
         YWEfdrha3uADqAhw0HgcSj255/JHaiLHGOq9Yvaa95oGDpk7oj+uo64M3qqyciQ1/EO2
         M1h4kXzgDwde53BahlA7OXS/xpbiphYmbi/agZAPJQ0YXCk0LxKafU9cFJugDW7iyoNK
         1Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727410451; x=1728015251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmPC7xOEq4xiQYbTsTCCja7E17GlGBjk59a6Y6qmbow=;
        b=wiM8P6i9hKJiC5jmI5DWytLSpSFq3kO9VrTJ4Fh7laoLO+ISo9MhDDsoUc6TL71Nsr
         aFp3rNsd08eDlK0uSoQugUcGcTyn6gGge3Nu6V73Sct5YAbGbBSQXKLlR3mReUbtfP3I
         a4+wtNCwry6zXLJoe5GRGYoix3D6Id751DD4Dyukkcv415H9hVpF0Tcfq1QBUmn+41qK
         vf35ssjZYgHDSTmInn2Ug9xLfWgvmNXoM8s/TbYzATZFbJe9A9Tjq4wJkfTM14IkF/Gn
         kaJrCwCFI+y9YrhNHwaEjJ9Jsc9YTGu+A13K8cD77fi5f11TTOlSTqyq8KGMkYY4202x
         e1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZXaP4ugo0HY8z39XAxnc/aTVg95XEsOxCLGvrPuxzlqBhWqOW55zJdes+CYxjy3rFtltoP418DUw@vger.kernel.org, AJvYcCWVGAweQmd4H+CmCPC7oOOe5JLlSXF4yBW0lGP2VjILbvhD/Z9KiTk/RU5kd9GAsN1jO1MZlcSlAfIB@vger.kernel.org, AJvYcCWXu8U7S+fM+wGO6M2BNFtzRXhESfxdtaarghy6FxdV4MWy3nQ5HxX1pc00i0q47cNvGGgIrTSeZRVMXYtZ@vger.kernel.org, AJvYcCXq99sVKXXEpdLOVNcuZbGagTUhoi5sBYWwJlRug5A+vPqDBev2z/lESzi2od5TFCFP3Ve9J3nlWn2e77on8hQ3@vger.kernel.org
X-Gm-Message-State: AOJu0YzfnI6O7hHO25AeH3gx+/yiaK0stT1Epe9H3OK5Cwo57bWXiHu7
	S5FcWZ0BwjogIjj1K5FJ4cgDPMRIWFNo0qPG4LmTw3yrAoP8ojNN
X-Google-Smtp-Source: AGHT+IHDmvSZ+vvEz962F4lkQhrBabPVtLhowwYwbXZHolk9sYGt9iof/C7/GGTTa5vwr7vZ0BjGBw==
X-Received: by 2002:a17:902:da81:b0:206:adf0:4f15 with SMTP id d9443c01a7336-20b367d035emr34323555ad.8.1727410450894;
        Thu, 26 Sep 2024 21:14:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2bc531sm689914a12.32.2024.09.26.21.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 21:14:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 26 Sep 2024 21:14:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	patches@lists.linux.dev, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with
 struct clk_parent_data
Message-ID: <6cd337fb-38f0-41cb-b942-5844b84433db@roeck-us.net>
References: <20240718210513.3801024-1-sboyd@kernel.org>
 <20240718210513.3801024-9-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718210513.3801024-9-sboyd@kernel.org>

Hi Stephen,

On Thu, Jul 18, 2024 at 02:05:07PM -0700, Stephen Boyd wrote:
> Test that clks registered with 'struct clk_parent_data' work as
> intended and can find their parents.
> 

When testing this on arm64, I see the error below. The error is only
seen if I boot through efi, i.e., with "-bios QEMU_EFI-aarch64.fd"
qemu parameter.

Any idea what might cause the problem ?

Thanks,
Guenter

---
[   20.464809]     KTAP version 1
[   20.464865]     # Subtest: clk_register_clk_parent_data_of
[   20.464936]     # module: clk_test
[   20.464979]     1..1
[   20.465098]         KTAP version 1
[   20.465208]         # Subtest: clk_register_clk_parent_data_of_test
[   20.468964] OF: overlay: find target, node: /fragment@0, path '/' not found
[   20.469558] OF: overlay: init_overlay_changeset() failed, ret = -22
[   20.470177]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
[   20.470177]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
[   20.470177]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
[   20.471793]         not ok 1 clk_parent_data_of_index_test
[   20.474095] OF: overlay: find target, node: /fragment@0, path '/' not found
[   20.474373] OF: overlay: init_overlay_changeset() failed, ret = -22
[   20.474737]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
[   20.474737]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
[   20.474737]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
[   20.477677]         not ok 2 clk_parent_data_of_fwname_test
[   20.479773] OF: overlay: find target, node: /fragment@0, path '/' not found
[   20.479941] OF: overlay: init_overlay_changeset() failed, ret = -22
[   20.480160]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
[   20.480160]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
[   20.480160]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
[   20.481513]         not ok 3 clk_parent_data_of_name_test
[   20.483711] OF: overlay: find target, node: /fragment@0, path '/' not found
[   20.483878] OF: overlay: init_overlay_changeset() failed, ret = -22
[   20.484100]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
[   20.484100]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
[   20.484100]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
[   20.485444]         not ok 4 clk_parent_data_of_fwname_name_test
[   20.487432] OF: overlay: find target, node: /fragment@0, path '/' not found
[   20.487600] OF: overlay: init_overlay_changeset() failed, ret = -22
[   20.487841]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
[   20.487841]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
[   20.487841]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
[   20.489207]         not ok 5 clk_parent_data_of_index_name_priority_test
[   20.490998] OF: overlay: find target, node: /fragment@0, path '/' not found
[   20.491504] OF: overlay: init_overlay_changeset() failed, ret = -22
[   20.491725]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
[   20.491725]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
[   20.491725]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
[   20.493053]         not ok 6 clk_parent_data_of_index_fwname_name_priority_test
[   20.493583]     # clk_register_clk_parent_data_of_test: pass:0 fail:6 skip:0 total:6
[   20.493701]     not ok 1 clk_register_clk_parent_data_of_test
[   20.493822] # clk_register_clk_parent_data_of: pass:0 fail:1 skip:0 total:1
[   20.493920] # Totals: pass:0 fail:6 skip:0 total:6
[   20.494032] not ok 49 clk_register_clk_parent_data_of

