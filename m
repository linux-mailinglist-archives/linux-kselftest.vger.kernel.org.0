Return-Path: <linux-kselftest+bounces-18442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25A987DA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 06:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C9B2427D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 04:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBA91714B5;
	Fri, 27 Sep 2024 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDEs4/Xo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A078158559;
	Fri, 27 Sep 2024 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727411980; cv=none; b=tiqGHGCxkzw4yKVpNrchPptNPgNnt1SlgsAZVf77SDRu7yz/A1VBf8f9u9M9Pwi++xMOKlvIJS9LuO7F/a+6yNywoWzDS45RUO6+a5z+JD4InOasWnmSC9ZfeSLlOKzhn1K1BYZrjzFHlIpTIZa3IZ7tSQn9AJExmKa2dC8jz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727411980; c=relaxed/simple;
	bh=fnuMouiKEyLaGvP0fibwaDVaQx4o0ggHSL2sDNMPTE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHB89PaGpE3i4UoxcbpFO1ZAcuC49pwBg7YrzSwAEW3gMi3Y93PZPhhWzCkP2ITTNTqp2fjTQBD4171cjsQarLLU2nngRBiSrnn8NO4i+6GcCCGzwLCbEmzoLCb9oY9GoIyGu1IMMoTIEi78KXMes2W56I9Xnlluf0nv4o/vN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDEs4/Xo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6afa8baeaso1397082a12.3;
        Thu, 26 Sep 2024 21:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727411978; x=1728016778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkeWKlYqDtXSyz5lb3aYllnaQqnV6uJYVg8fzlxg5tg=;
        b=iDEs4/Xorkfa3zfrfqQkfCnh2Dr6PmTR5VkGj0feXmPhfljq1RAJ78e9ufwYr+AYxs
         /V13RJEoahDcsK8mJ9dpYu0S1evMrkGQlMW1iXFfmdqQ2dHxiWoqYRE0eiarLtWuKEnf
         4O3yjDpUd088bl3w6bLM0JVyWXbhDkEYJ9IsbiNAkrN6tprs0Z9q5Y8WplAdxL/28HO+
         +DKK+LvSLK4WlFeC2dare5aAFtHDoQYtx+gUYc31tpVJUDDDK6YDw4I95wfDF85ySuoe
         7To3Oc975vp9PRqqtAnmxZut4GtNI3HXrt4aPV/LiP/htqGVVwhYA5uJXTr9zOfACXCr
         BCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727411978; x=1728016778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkeWKlYqDtXSyz5lb3aYllnaQqnV6uJYVg8fzlxg5tg=;
        b=oPjM2pddSxYVk+WwksoUrwChuw5kBV5ysxZYai520VE5Zq9mh8FfOIDpO+XQsRxTFH
         alaQpZg8Eb9TJmR3Vg9fC3Tv9Kg/qTYUg/Lj2RARI+DQcBD0AhFOOZBXIcicm1dGpW1R
         4MXVOeYBH6AuPbcyE7UwgT+77oZEvFFaPAfLg91c6fS1SQr0gD8nMVrT/LBI/RxiaGyY
         RgNwX6sLDSvAtg8BP3mu8BqOnhfkl+PNgig7K1WLhxP9+DVpu3pfaFtpxJxGuul/S2JA
         lt1vXOIY8VL5C4VUudhL9qFNJXtlrtiiPM5xeLC9zyLaZNHw2isDwo7PjS62bUJMWyh/
         4t2g==
X-Forwarded-Encrypted: i=1; AJvYcCUjCtdQJHKG3+SE9v0UaBgpgz00ZzQCRN6WiSWCPE5M73L4GlnkhefapmNcqH4MdXO4M2ryptR5bFesXCIe@vger.kernel.org, AJvYcCWAayJqMMzrndRl2FJ15X7lTyE8ce4nI3JJ8GjqbW3K8Ft5/4sQ1NtaUjOcgP9wcFE7QPgFS0U9WBWr@vger.kernel.org, AJvYcCWNHtvA2P2LlwP6opP6TtOEx0lVcIQDfQciP5ByJ0vlcNJ4UZ8KbnXPCdBsBe2Zy+4Kb4cPRQ4FbSTw@vger.kernel.org, AJvYcCXptez1Wh0u2LUhGxgi3LEqorbD4YXFXlU9CDBoqtS5yXz5UTQm9Pe0qhiSrpxgGlHE1DX225EvgAqtZ0wcMXDq@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfoR99+DWz0XpsdXHeUR6n6+yduX7VFTMCkS4UejQLDfkGw/t
	nQT6DS7uvl2y5xPOS0qdwgzlfx2YwNwlsGA7VN+l9dxGg6KSAxzH
X-Google-Smtp-Source: AGHT+IEfM+rRMxnYnAc6tMRBBhgU2qe67B99fXVKBiUZ3r0r2t2KmJEVITgi/OZS2CHi1py9nNGxkg==
X-Received: by 2002:a05:6a21:3405:b0:1d2:bb49:908b with SMTP id adf61e73a8af0-1d4fa67b980mr2948871637.18.1727411978276;
        Thu, 26 Sep 2024 21:39:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db60e3fasm721443a12.78.2024.09.26.21.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 21:39:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 26 Sep 2024 21:39:36 -0700
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
Message-ID: <a339ec8c-38f6-425a-94d1-ad69b5ddbd88@roeck-us.net>
References: <20240718210513.3801024-1-sboyd@kernel.org>
 <20240718210513.3801024-9-sboyd@kernel.org>
 <6cd337fb-38f0-41cb-b942-5844b84433db@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd337fb-38f0-41cb-b942-5844b84433db@roeck-us.net>

On Thu, Sep 26, 2024 at 09:14:11PM -0700, Guenter Roeck wrote:
> Hi Stephen,
> 
> On Thu, Jul 18, 2024 at 02:05:07PM -0700, Stephen Boyd wrote:
> > Test that clks registered with 'struct clk_parent_data' work as
> > intended and can find their parents.
> > 
> 
> When testing this on arm64, I see the error below. The error is only
> seen if I boot through efi, i.e., with "-bios QEMU_EFI-aarch64.fd"
> qemu parameter.
> 
> Any idea what might cause the problem ?
> 
I noticed that the new overlay tests fail as well, also with "path '/' not
found".

[Maybe] answering my own question: I think the problem may be that there
is no devicetree file and thus no devicetree root when booting through
efi (in other words, of_root is NULL). Would it make sense to skip the
tests in that case ?

Thanks,
Guenter

> Thanks,
> Guenter
> 
> ---
> [   20.464809]     KTAP version 1
> [   20.464865]     # Subtest: clk_register_clk_parent_data_of
> [   20.464936]     # module: clk_test
> [   20.464979]     1..1
> [   20.465098]         KTAP version 1
> [   20.465208]         # Subtest: clk_register_clk_parent_data_of_test
> [   20.468964] OF: overlay: find target, node: /fragment@0, path '/' not found
> [   20.469558] OF: overlay: init_overlay_changeset() failed, ret = -22
> [   20.470177]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
> [   20.470177]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
> [   20.470177]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
> [   20.471793]         not ok 1 clk_parent_data_of_index_test
> [   20.474095] OF: overlay: find target, node: /fragment@0, path '/' not found
> [   20.474373] OF: overlay: init_overlay_changeset() failed, ret = -22
> [   20.474737]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
> [   20.474737]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
> [   20.474737]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
> [   20.477677]         not ok 2 clk_parent_data_of_fwname_test
> [   20.479773] OF: overlay: find target, node: /fragment@0, path '/' not found
> [   20.479941] OF: overlay: init_overlay_changeset() failed, ret = -22
> [   20.480160]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
> [   20.480160]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
> [   20.480160]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
> [   20.481513]         not ok 3 clk_parent_data_of_name_test
> [   20.483711] OF: overlay: find target, node: /fragment@0, path '/' not found
> [   20.483878] OF: overlay: init_overlay_changeset() failed, ret = -22
> [   20.484100]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
> [   20.484100]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
> [   20.484100]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
> [   20.485444]         not ok 4 clk_parent_data_of_fwname_name_test
> [   20.487432] OF: overlay: find target, node: /fragment@0, path '/' not found
> [   20.487600] OF: overlay: init_overlay_changeset() failed, ret = -22
> [   20.487841]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
> [   20.487841]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
> [   20.487841]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
> [   20.489207]         not ok 5 clk_parent_data_of_index_name_priority_test
> [   20.490998] OF: overlay: find target, node: /fragment@0, path '/' not found
> [   20.491504] OF: overlay: init_overlay_changeset() failed, ret = -22
> [   20.491725]     # clk_register_clk_parent_data_of_test: ASSERTION FAILED at drivers/clk/clk_test.c:2760
> [   20.491725]     Expected 0 == ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }), but
> [   20.491725]         ({ extern uint8_t __dtbo_kunit_clk_parent_data_test_begin[]; extern uint8_t __dtbo_kunit_clk_parent_data_test_end[]; __of_overlay_apply_kunit((test), __dtbo_kunit_clk_parent_data_test_begin, __dtbo_kunit_clk_parent_data_test_end); }) == -22 (0xffffffffffffffea)
> [   20.493053]         not ok 6 clk_parent_data_of_index_fwname_name_priority_test
> [   20.493583]     # clk_register_clk_parent_data_of_test: pass:0 fail:6 skip:0 total:6
> [   20.493701]     not ok 1 clk_register_clk_parent_data_of_test
> [   20.493822] # clk_register_clk_parent_data_of: pass:0 fail:1 skip:0 total:1
> [   20.493920] # Totals: pass:0 fail:6 skip:0 total:6
> [   20.494032] not ok 49 clk_register_clk_parent_data_of

