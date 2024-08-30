Return-Path: <linux-kselftest+bounces-16846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF0A966920
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 20:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B01F226CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3026B1BAED9;
	Fri, 30 Aug 2024 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enndAzVf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E814D2B1;
	Fri, 30 Aug 2024 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043667; cv=none; b=FibCFm5xZwKssKtWIKTn3RjwoRRc13bD7l3hhtwY1aMyYOE3kUsdoyXvN751q4eUpuyThY0OBZvM7ulvNNVzJQasYZj+Qd5QZEhFgKuKf115TLyQKbHT8l9ZaV8/HxSB1V1rL4TWlPTkhdEkVfWz2w1jdrvfF5/ditmdkYglDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043667; c=relaxed/simple;
	bh=O0K//g9rblJMMkUjlCWy3HPerR4FU4Vv3JKV5mLwdRI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IpYX8k8U8vH/D5ynJxo3NERqsW5tPNf1FC0w5VpCPSosz4cKH5P+H+YNmShuAcEP8+9KDtvJAgcEbQYABZK38Z7LM4SrnCEbz0g3SjtjC/Lv2fY36K3iGXfnYR42alW2SLhUwa5tK/rEpRKFieQd6fhtnRC3pryow8oQ+Fe+JPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enndAzVf; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf92f96f83so11688616d6.3;
        Fri, 30 Aug 2024 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725043664; x=1725648464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJKg/IrPQbYz6rVsgOp5ZQDc2rLl2ZLh7z0+LtKiQVU=;
        b=enndAzVfgonEF8cF2T3NrF8uxzDfD4vxcRiXX6QNtLNSx9SP2AaD66sDFiH7RCZD/k
         HyKq8HiN5MKFP3A+meelDEukkmPbGLHkv4/sbQdqeiIxiIqShzNtcWH8SIXiMhB0CfIS
         sm0EBHzQGVsbaMDcOfl2drdppYqD8Enk3Qs+x6p4Bvnd+KDpIrg2yRO28STOENGbau5g
         ++ZPW5wL6wI6NFqLLE0a3pawFcqxQ1flP+uz79VGOr0bNpA/wtn/7zKtuL9sDqGpYTvq
         LKbYb45McSWOQ96gwJo0rR0SsxmTvCF746BFdLmNAymJ60VLDfo4QbyDSgiFZSy+7agM
         txcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725043664; x=1725648464;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EJKg/IrPQbYz6rVsgOp5ZQDc2rLl2ZLh7z0+LtKiQVU=;
        b=s2HzUfRFEIhnmap9TTEzLCWEc3GdIfnGsirIHCb95rs3R39/+GN8e7NnQ4ht3oHQHI
         NbqhXaQ9eL4q+tVIljdd5aD1mevvB2mayXGtJaVk5ZUCKi/hKMdNKEiwhTaStpCobGYs
         BhT0s7NvoLLc7beKkLKJ51uYq2Fv12OV/janERwJ3oJ6alIFMEqwXW2+b/DRHL5VnH5s
         KOq1bNhWU28pXwZzi5OLwJ2xZ8JDUFTKF7OJFYrFMjN0k4X7cv2wZrJ08fcLFtLtgE6W
         uJaadacI3rvJCGzIASDUUhcFsOKX1gtWx7WLWeKljWgOAf3zU7hCJPvBGlvt1eHds9eO
         ipOw==
X-Forwarded-Encrypted: i=1; AJvYcCVa/uDIF4prq5QWUUjAVRjQVKGiUHfpIDUZVYJWuXQCYwX9iAjuX1WmADtcKYlgo/UY7NdujEY6noO0heaeSdw=@vger.kernel.org, AJvYcCVmrfUnZXzBsLL5wkPdp6/AP4uwLYh4hO/4pDAUtJ02OBywTUCfBnalyhI36fwURtphcY+1QKsI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84e5T4+s5DUDwPbg2BBxkKJDj//EnT/ncFLTGTjlWoTzoIZHr
	PZc0027BODmKhuFgLxn8KcCoRkfpRy93DmNGy4sHsZxaN5FP0vHrk/Clelsx
X-Google-Smtp-Source: AGHT+IG7scXD36icqYhW7HgnM0CF7QcEQFjNdpMYprOnzawvsdHJVUA7iVncwEHTp5LAi/6NNaticg==
X-Received: by 2002:a0c:f78a:0:b0:6c3:55be:23a4 with SMTP id 6a1803df08f44-6c355be2450mr3586816d6.1.1725043664355;
        Fri, 30 Aug 2024 11:47:44 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340db411esm16802356d6.146.2024.08.30.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 11:47:43 -0700 (PDT)
Date: Fri, 30 Aug 2024 14:47:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
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
Message-ID: <66d213cf6652e_3c8f2d294b8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240830103343.0dd20018@kernel.org>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
 <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
 <20240828090120.71be0b20@kernel.org>
 <66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
 <20240828140035.4554142f@kernel.org>
 <66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
 <20240830103343.0dd20018@kernel.org>
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

Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 11:20:05 -0400 Willem de Bruijn wrote:
> > Kselftest install does not preserve directories.
> > 
> > So all .pkt files are copied into net/packetdrill root. This is messy.
> > More fundamentally it breaks the includes in the files (e..g, `source
> > ../common/defaults.sh`).
> 
> Can you show an example of exact commands and what happens?

Running directly works fine:

    $ KSELFTEST_PKT_INTERP=packetdrill_ksft.sh
    $ make -C tools/testing/selftests \
            TARGETS=net/packetdrill O=/tmp run_tests

    TAP version 13
    1..3
    # timeout set to 45
    # selftests: net/packetdrill: client.pkt
    # TAP version 13
    # 1..2
    # ok 1 ipv4
    # ok 2 ipv6
    # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
    ok 1 selftests: net/packetdrill: client.pkt
    [..etc..]

Installing does not:

    $ make -C tools/testing/selftests/ \
          TARGETS=net/packetdrill \
          install INSTALL_PATH=$INSTALL_DIR
    $ cd $INSTALL_DIR
    $ export KSELFTEST_PKT_INTERP=packetdrill_ksft.sh
    $ ./run_kselftest.sh -c net/packetdrill

    TAP version 13
    1..3
    # timeout set to 45
    # selftests: net/packetdrill: client.pkt
    # TAP version 13
    # 1..2
    # sh: line 1: ../common/defaults.sh: No such file or directory
    # ./client.pkt: error executing init command: non-zero status 127
    # not ok 1 ipv4
    # sh: line 1: ../common/defaults.sh: No such file or directory
    # ./client.pkt: error executing init command: non-zero status 127
    # not ok 2 ipv6
    # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
    not ok 1 selftests: net/packetdrill: client.pkt # exit=1

Due to that relative path to defaults.sh inside the scripts.

It is arguably a bit weird that the relative path of the TEST_PROGS
differs before and after install.

> We have directories in net/lib, and it's a target, and it works, no?

net/lib is not a TARGET in tools/testing/selftests/Makefile. Its
Makefile only generates dependencies for other targets: TEST_FILES,
TEST_GEN_FILES and TEST_INCLUDES.

This issue with preserving paths until recently also existed for
helper files (TEST_FILES). TEST_INCLUDES was added expressly to
preserve those paths (commit 2a0683be5b4c).

