Return-Path: <linux-kselftest+bounces-17342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020BE96E74F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 03:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBADB23C0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 01:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA4199B9;
	Fri,  6 Sep 2024 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncr9+1/m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E7D2FF;
	Fri,  6 Sep 2024 01:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725586319; cv=none; b=Vt//zIzp6tl9C6GA7Wj09g5AvT5XhzePAx4FuI4awweFoqzhVBeYbl7YGTzkBJQ+k8oV9Vjde5XqINLSXzCj2kEGYmYGWXNUpffPPnZ4nZZMFO4Sqmb7LVj83Yc1eTQwmY9YAVunXJjWNHD3qVAaldLj8GoMspRNDX/F68Goq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725586319; c=relaxed/simple;
	bh=wNOGpVDHYK+KYBx/8/ViEpGtsG6DpolNj8+hUpP8I9c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WGucsPVwLXphij+kmqtfUdWXeiKyVBdzXyWE6thWZ5sPCtJC2F7vhqBQOVJxjI4MjOd7S9TIiSbPqE9mZ31nMFs27DWV5Gwv5xUvJCdWd0HZ02qGwFg9S1XiTnLDpERCToW8u8AA6A5HZ5pQiwwgmuWxP5ppZtgZOnyfM6NrO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncr9+1/m; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45677965a0eso8694741cf.1;
        Thu, 05 Sep 2024 18:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725586316; x=1726191116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N0/MpJbV1SzOtu1txuFL6acGqxUFDg2ThOtQ0TWZds=;
        b=Ncr9+1/mi9dWYd7O2AHg/COS4n5CrLKzad6sQzYsiErV+sytcYWmrZ1cKvJHqRyk1x
         8+6PGg6AtJF/lGkOUG/yuG8+YgA86AAUjhTSmZ8t/8nSwAhhujaHmMcBKHoVBcc3+s2s
         wNLFWYNca/Y55PFS5yVgRWlJ/8ftI4ATiQ9zmwdk0fnKipB0SgYBGAcSvOb35U/9c6B4
         Rp6ozx9gxCfaXb1gfwA56tazHEZaqs8JJ79OrEbjQcmRM/fTcx3SgV2JKlHpLzzz2fVM
         dqYg2rAkVQIkbs3jTa9e0jiss25ounAnZgRDUlNgw1GEEPoCSqigTk8tNgHqWlnAH2DM
         uznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725586316; x=1726191116;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9N0/MpJbV1SzOtu1txuFL6acGqxUFDg2ThOtQ0TWZds=;
        b=TgCcROQ2yIfW5pQ3QiJbsgXqv2ISKgDhT1T6q29BH2CjUo4uadYz+M/2D9je2bLW8L
         ZLOqqDe6kemFCND7ub21BgFUFc8nJW+JDovszMhgfwErelhN8EgDdno1lyS4S6dWYblX
         Bt0VP6kbm428VgpJ+hopqvISer+vOvUrJsQTrLYOzjoBAq1Q55LCEaHI7+fRZgdH4EX1
         qrm8itnhxrn3SVVRkijeXbpmqKHBex/OtW9Ah1zB5kMJGZtSGeAVKoUFKeYa5/cUNU4E
         DgUYpgtkoejD7JIMwS1n8iV3/mvK4lnAfdnwkiIdcwEi2prW4C7k/cFPC3xPTGjmLrbX
         sCYA==
X-Forwarded-Encrypted: i=1; AJvYcCWyUXx5O7onqxDm9xReXnWkPY91Kl16sgtewnnDy9kubtdQkfU4uiynIpIXZQK0rNSJPn7t/KomHQhv8aCGQIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiV0LpLXaP+Hg0J7n3Jk0n2eaJVxsn/ymkTPSECPg37sA166+g
	LbuFRZiTm2at7hD2iMhQDPYPt5euiZ9V08izXupzuv0GrlbPcitE
X-Google-Smtp-Source: AGHT+IHPOzjz0d2JbLZTRY59ZLcIP5OZuvTxmdKNIDwDjYIj0vE1KxDtyc8KMf/buVx8UuglSDpHcQ==
X-Received: by 2002:a05:622a:155:b0:456:7fb5:104b with SMTP id d75a77b69052e-4580c4f32c9mr17696101cf.0.1725586315939;
        Thu, 05 Sep 2024 18:31:55 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801dc238esm12096321cf.89.2024.09.05.18.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 18:31:55 -0700 (PDT)
Date: Thu, 05 Sep 2024 21:31:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66da5b8b27259_27bb41294c@willemb.c.googlers.com.notmuch>
In-Reply-To: <66da4ab570989_269be02944d@willemb.c.googlers.com.notmuch>
References: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
 <20240905031233.1528830-3-willemdebruijn.kernel@gmail.com>
 <20240905143128.0dde754f@kernel.org>
 <66da3dabc3f71_25102d29476@willemb.c.googlers.com.notmuch>
 <66da4ab570989_269be02944d@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next 2/2] selftests/net: integrate packetdrill with
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
> Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > On Wed,  4 Sep 2024 23:07:03 -0400 Willem de Bruijn wrote:
> > > > +++ b/tools/testing/selftests/net/packetdrill/config
> > > > @@ -0,0 +1 @@
> > > > +CONFIG_TCP_MD5SIG=y
> > > 
> > > Looks like this is not enough:
> > > 
> > > # 1..2
> > > # open tun device: No such file or directory
> > > # not ok 1 ipv4
> > > # open tun device: No such file or directory
> > > 
> > > https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/1-tcp-inq-client-pkt/stdout
> > > 
> > > Resulting config in the build:
> > > 
> > > # CONFIG_TUN is not set
> > > 
> > > https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/config
> > > 
> > > Keep in mind the "Important" note here:
> > > 
> > > https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-build
> > > 
> > > I recommend using a fresh tree or mrproper for testing vng configs.
> > > 
> > > Feel free to post v2 without the 24h wait, it's a bit tricky to handle
> > > new targets in CI, sooner we merge this the less manual work for me..
> > 
> > Oops sorry. Thanks for the pointer.
> > 
> > Sent a v2 with CONFIG_TUN and a few other CONFIGS from reviewing
> > the existing configs and defaults.sh. The above steps work for me now. 
> 
> Packetdrill scripts are sensitive to timing.
> On the dbg build, I just observe a flaky test.
> 
> The tool takes --tolerance_usecs and --tolerance_percent arguments.
> I may have to update ksft_runner.sh to increase one if a dbg build is
> detected.
> 
> Let me know if I should respin now. Else I can also follow-up.
> 
> Need to figure out how best to detect debug builds. It is not in
> uname, and no proc/config.gz. Existence of /sys/kernel/debug/kmemleak
> is a proxy for current kernel/configs/debug.config, if a bit crude.

Should have kept on reading. Will use KSFT_MACHINE_SLOW:

+declare -a optargs
+if [[ "${KSFT_MACHINE_SLOW}" == "yes" ]]; then
+       optargs+=('--tolerance_usecs=10000')
+fi
+
 ktap_print_header
 ktap_set_plan 2

-packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
+packetdrill ${ipv4_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
        && ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
-packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
+packetdrill ${ipv6_args[@]} ${optargs[@]} $(basename $script) > /dev/null \
        && ktap_test_pass "ipv6" || ktap_test_fail "ipv6"


> Another config affecting timing may be CONFIG_HZ. I did not observe
> issues with these specific scripts with CONFIG_HZ=250. It may have to
> be tackled eventually. Or CONFIG_HZ=1000 hardcoded in config.
 
I will just add the CONFIG for now.


