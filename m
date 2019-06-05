Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A42E359FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2019 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfFEJ4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jun 2019 05:56:40 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:33499 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfFEJ4j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jun 2019 05:56:39 -0400
Received: by mail-lj1-f180.google.com with SMTP id v29so11279883ljv.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jun 2019 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aTpgLOLiOcdUseee8sGCuUVr8+ArZkun+6MaGgEufC8=;
        b=xYcIR3XRYyaHaraWVu3zdo2mKco43ufVFoy+mPt8RfbdAleN3jO/ctNr+7eRIHGQi/
         wRpa+L3/6L4t1W79cAyYZQ1iky5uU+cC1yT7/nfYSVjbaxocW0PVoz6Fv9AW+dCt2aMv
         Ampk9dRzdgf7PGveMId9ZlwTO0of3LcOIFhc2zOVC0LMn0X9sunpCPt3kK4JQ5+k+xPX
         8ucoO+ut5voMT6ZKJuYgHAA7PhUC5nF0oEgarKytBoPastbd2PTqhUc68I9mgzEIfp0I
         2CZRuvkbwkgrsuG/SJDQ8dBx58HxDd0Sszq7REXxi3M9SRvH8Fs5U8HJEPTmklYQ7K+h
         gMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aTpgLOLiOcdUseee8sGCuUVr8+ArZkun+6MaGgEufC8=;
        b=LdybF9IcSh/9HgRuumhU/BR7o21oR5s7zstQO1IeZUJz0+Da3TC0eRURQITLbKam1m
         Dso+uou4zRh2yVnoGkxw/4IIvCdSbHCy4mA3kuayCJJJbJwxTNxqta2sVCcZ+gjyg5v0
         szenp2XjJkuGbA4LMMxywMdJE1qb8Obj+sTFE6z4tzDlSP/D1b4dOHJgnl5mlL4KkdF1
         2NP80mNCvqmS8/g8JvQ+MxgFtDOC3X14f6fVIC0bZOmbNFWPHuXC8/5INbaymG5x31yu
         pnIAmVm5cEDjyHkDawRx+tPm9Yry8FbwXy4giFDLjFKZgL4y3pZ+VnZtoKnw9d7YoBF7
         ha9Q==
X-Gm-Message-State: APjAAAUw6hwv57B2O/q8v/Qk7Nl5BUhrvaJQ52/+nYmNlUvtBko3j+Y6
        md1Z/G/Z6ph4C3vhi7YmcWcRGtIo/B5AscFIzNliiw==
X-Google-Smtp-Source: APXvYqwnWF5l3td0n7SMWT3OVQ35nHkAIuh7b6vyqeeLI2XK8i46f9Yz0Qu8nSqskWQfhfDgC8spm6+/DFSkJFI6178=
X-Received: by 2002:a2e:2b11:: with SMTP id q17mr20580986lje.23.1559728597600;
 Wed, 05 Jun 2019 02:56:37 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Jun 2019 15:26:26 +0530
Message-ID: <CA+G9fYtTcV9Xa65COdNfA9O+BvZV64fWBvdaamRLZphWEn7FXA@mail.gmail.com>
Subject: selftests: bpf: test_sock_fields: Error: in_bpf_create_map_xattr(sk_pkt_out_cnt)Invalid
To:     ast@kernel.org, kafai@fb.com, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Do you see this failure at your end?
Our environment is build on host and install them on target device and
run on Device under test (DUT).

Did i miss any kernel config fragments ?

bpf: test_sock_fields_ #
# libbpf Error in bpf_create_map_xattr(sk_pkt_out_cnt)Invalid
argument(22). Retrying without BTF.
Error: in_bpf_create_map_xattr(sk_pkt_out_cnt)Invalid #
# libbpf failed to create map (name 'sk_pkt_out_cnt') Invalid argument
failed: to_create #
# libbpf failed to load object 'test_sock_fields_kern.o'
failed: to_load #
# main(439)FAILbpf_prog_load_xattr() err-22
err-22: _ #
[FAIL] 22 selftests bpf test_sock_fields
selftests: bpf_test_sock_fields [FAIL]

Full test log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190605/testrun/761646/log

Config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-next/536/config

Test results for comparison,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/kselftest/bpf_test_sock_fields

Best regards
Naresh Kamboju
