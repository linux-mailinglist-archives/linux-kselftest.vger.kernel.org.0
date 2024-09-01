Return-Path: <linux-kselftest+bounces-16915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68461967C49
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 23:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F58D281AB5
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B4136982;
	Sun,  1 Sep 2024 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B775IGcl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9342040;
	Sun,  1 Sep 2024 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725225342; cv=none; b=tQ/ubRLuGd+dpNLSHD+DLdjbLGjldxBN0bJOX2qmsW0IoAsjJe1UxeNdZk5XtugvPLixe0nld1GLMc6a1pjjUhYrG87+gyaEZimeMQYjZ5UJSWZaiGeTtz2+qfIqP/dvLDVy82eP3w0OFZ+uODtykzOc54JK5DBNgeyWRkRpt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725225342; c=relaxed/simple;
	bh=oIawsn4XjXyba9/w3c4J7HPxsOq0x/mN75IJv7Z502k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p3lmmyHwwEfbX6ZTgXsHakreZk9JeGUvmVdSTOTfs/qaMBSy8XZCIyvkh73xJOFrSvJ2vwxFbAKcHrbVF2mDCfOZfpPN2S+/iTp5fSDkfr10aKqUx3gnQT59s6tD/fRqVnRk3G2GCsaBs3H4a1hxRci2RpM/U81V7a+6Agtu7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B775IGcl; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70f79f1e1fbso705703a34.1;
        Sun, 01 Sep 2024 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725225339; x=1725830139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5/a2+9cfrFcbISuYbj8mbeAGRZCXc+y+jEmSoX7Qyg=;
        b=B775IGclzvlaEgSlpQ/YrA9n0bDrC4N0RXIQt63A1sA+xb/7HwvbOEYFyVYovx924q
         kLQElBUla/gVCJvOe78L/JPZipUmIPesFaRIR6O9Sxa96S2LFUDeYiwlEj+IO3ggHylB
         jzffq1vWYbs4CQvXHc1jmnQlbEPlpYDHXevbtDHnnYPmTjpw7rXyEVwte1uGwKoKFcPH
         k/A8eofTKweWY6TlhyVtN+3HeutWPgSxAO92AHYV46li8jUa9mTsTr6H6fClZ+lYisDR
         az8RPv0atNBrOtHZE0v3TrVJ4ZZCkxgTT1K5yKWXNoiDtnI1fcuQyCjqSQz4gZu7I9YS
         7OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725225339; x=1725830139;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W5/a2+9cfrFcbISuYbj8mbeAGRZCXc+y+jEmSoX7Qyg=;
        b=f9664DIzUmqbzvF1Tl/pa9M4g8X3h2tA9F96qKOFMJU7dG+9NwPrnlrCeaRWPYa3+3
         FxImZHWxdQQfU1knkd1av/3DQGtv+iCoUHrf+2hrZ0Y4e8Gzf7i2DwYj+y5xwWA4QPlx
         9G0LIRE9RU2A5XgvYCpOa3eFJ+r97Pezaur3WOJ/ALF2IMBPt4QwuZQaAeEZ9VD1ZLww
         XPHLkFAJCUAnZF8BEGh5eVveEIJQv8Oky5TOTu2aUxUaVL7luaKUPTtlHhG3Ba3Kd+IK
         xEIZNbrYFiZazzIiQfkiGPN/F+7vgWMn7PnFaNfn4FYqIlxpgOEgWQpaviMd2R4sPSkM
         n0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW88oi8pFioIMrge+8172OX+Xq7QoKIfn8qo3wD9EslAd971ludszmeMHhJRDCv/tgLyOqi8swN@vger.kernel.org, AJvYcCWPGU1eSaSRtiwLlK762tt4AvkmCK3Nx9O48QbnN7q7ykB4ZAUP7M+2RaIvGmkOyzMHtCVVwsMRHJSaaIHkQq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLENXPQ3pDQVCaFKQM5IS5O3VpuzX4XqwoSh0GQJpFmBhvrho
	SbojH6NGbRW211BNt1KWPRuhIpvusa4UcCdBZ4wHxgmg+wQA6BSE
X-Google-Smtp-Source: AGHT+IEhwVjj8C2yiuOVJL1bxa6JpcbkZN8EYVchnmh7iJLNlBWvGD4c4GKyFzIESXsUTL50uOVTXA==
X-Received: by 2002:a05:6830:6401:b0:703:6d27:63e0 with SMTP id 46e09a7af769-70f5c466ffemr13633305a34.26.1725225339241;
        Sun, 01 Sep 2024 14:15:39 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d95fa2sm34107741cf.87.2024.09.01.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 14:15:38 -0700 (PDT)
Date: Sun, 01 Sep 2024 17:15:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 martineau@kernel.org
Message-ID: <66d4d97a4cac_3df182941a@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d23f2349f7_3d8dba29489@willemb.c.googlers.com.notmuch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
 <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
 <20240828090120.71be0b20@kernel.org>
 <66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
 <20240828140035.4554142f@kernel.org>
 <66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
 <20240830103343.0dd20018@kernel.org>
 <66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
 <20240830144420.5974dc5b@kernel.org>
 <66d23f2349f7_3d8dba29489@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Fri, 30 Aug 2024 14:47:43 -0400 Willem de Bruijn wrote:
> > > > We have directories in net/lib, and it's a target, and it works, no?  
> > > 
> > > net/lib is not a TARGET in tools/testing/selftests/Makefile. Its
> > > Makefile only generates dependencies for other targets: TEST_FILES,
> > > TEST_GEN_FILES and TEST_INCLUDES.
> > 
> > Oh right, TEST_FILES vs TEST_INCLUDES :(
> > 
> > Looks like only x86 does some weird stuff and prepends $(OUTPUT) to all
> > test names. Otherwise the only TEST_NAME with a / in it is
> > 
> > x86_64/nx_huge_pages_test.sh
> 
> Oh interesting precedent. Let me take a look.
> 
> > But then again maybe we should give up on the idea of using directories?
> > Use some separator like --, I mean:
> > 
> > mv packetdrill/tcp/inq/client.pkt packetdrill/tcp--inq--client.pkt
> > 
> > Assuming we're moving forward with the interpreter idea we don't need
> > directories for multi-threading, just for organization. Which perhaps
> > isn't worth the time investment? Given that we'd mostly interact with
> > these tests via UI which will flatten it all back?
> 
> That's definitely simpler :)
> 
> I'd like to keep diffs between packetdrill scripts on github (and
> Google internal, we have more) and selftests to a minimum. This is
> invertible, as is rewriting source statements inside the pkt files.
> But that might be more work and more maintenance in the end.

Thanks again for the pointer and suggestion.

Changing kselftests to preserve directories turns out to be trivial.
Patch inline below.

But, existing TARGETS of course then start failing. Because they
depend on existing rsync without -R. In (at least) two ways:

amd-pstate fails because its TEST_FILES has includes from other
directories and it expects those files to land in the directory
with tests.

x86 prefixes all its output with $(OUTPUT) to form absolute paths,
which also creates absolute paths in kselftest-list.txt.

These two are examples, not necessarily the one instances of those
patterns. So switching to preserving directories for existing targets
like TEST_FILES seems intractable.

Plan B is to add a new TEST_PROGS_RECURSE, analogous to how
TEST_INCLUDES extended TEST_FILES with optional path preservation.
That is not much more complex.

---

+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -101,7 +112,7 @@ run_one()
                echo "# timeout set to $kselftest_timeout" >> "$logfile"
        fi
 
-       TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
+       TEST_HDR_MSG="selftests: $DIR: $TEST"

+++ b/tools/testing/selftests/lib.mk
@@ -150,7 +150,7 @@ clean_mods_dir:

 define INSTALL_SINGLE_RULE
        $(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
-       $(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
+       $(if $(INSTALL_LIST),rsync -aR --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
 endef

 define INSTALL_MODS_RULE
@@ -180,8 +180,7 @@ endif
 
 emit_tests:
        for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
-               BASENAME_TEST=`basename $$TEST`;        \
-               echo "$(COLLECTION):$$BASENAME_TEST";   \
+               echo "$(COLLECTION):$$TEST";    \
        done



