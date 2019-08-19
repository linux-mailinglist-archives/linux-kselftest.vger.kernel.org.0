Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C66294FE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2019 23:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfHSV3Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Aug 2019 17:29:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39179 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfHSV3Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Aug 2019 17:29:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id 125so2754489qkl.6
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2019 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0l0Pa0ElqK1DZWn0mgQwwfUufG1B6hMxS63646CFTfA=;
        b=vFz2D+dsGimCQxKLYPtL7kb/5ZcKWdyiABI2FKvG71x0Bt4YfuWuG8RNWUymu7+m63
         icUb3o9Hvu2mjZDqcuQyJtpfPz5WuJcFWSV08m2zKHRq/736D558UHD2+TfpavBooYE3
         byafPyfYpri+HCXimSPC/s+okyeKn7GYqvUg8KLPFFH9IGtta2DBVXasDP3o7kU+B8yB
         hK/qkWZIQdl/8ts0c2lDMC2hRpXdo/dkSgNJ1SHd5k1sRjw1okoGZcVA05Lyls1/vxUr
         mJMEMOnaJPE/nidQWBE9NTNc2+pgrZJlIQ33GP1teo9fmrNqtBtrDfFPTHrzVK1dE2PH
         /AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0l0Pa0ElqK1DZWn0mgQwwfUufG1B6hMxS63646CFTfA=;
        b=Tmbw/BMG87TMKxZQ3WqhlVEcWTPg0eyZMyr8KQLFQdQMLl+obVfXOM+H4urn4AHNv3
         NeldXSy+1b1ylTBV5m6OWSmn1EmdXX5oFNo3FLPUEF6jQhbgW5+9WhmYmkjtiGf1Bntd
         pbVdlm/QNAvBluLEDnM8ZGae/LgrcVmUe6b1C81RMNfRwZDqwNygGnnplABBomjf4kjU
         0D0dmeEuECSQmVDErhpNiRhujaMV5pQ3r+GBRfygiT8pYH5urR35+Q12qC0O8kwpkvsy
         8fgecq1TKdesNeO3gendPG2kkbtI5X4QlZyVU1CPmry951qNejV3Bcz10pZKi9mdnAbP
         Sy2w==
X-Gm-Message-State: APjAAAXn0r7Zn6NgTSzeCopSi9FCCASLMhBn/tA1udTzNoklcUBaTO3T
        7+irBcoI9a1UWjdHr6qe6Ltu/A==
X-Google-Smtp-Source: APXvYqzTQy/Lr6Ti+E/hIvFy1hXuDHcWSKY1hLZDpyObSYqbHZKCD29b41aVxncBy/HWCPAzxZo3yQ==
X-Received: by 2002:a05:620a:10ae:: with SMTP id h14mr7798507qkk.40.1566250155654;
        Mon, 19 Aug 2019 14:29:15 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h26sm8387575qta.58.2019.08.19.14.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 14:29:15 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:29:08 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     syzbot <syzbot+23d9570edec63669d890@syzkaller.appspotmail.com>
Cc:     ast@kernel.org, aviadye@mellanox.com,
        bhole_prashant_q7@lab.ntt.co.jp, borisp@mellanox.com,
        daniel@iogearbox.net, davejwatson@fb.com, davem@davemloft.net,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        shuah@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in tls_setsockopt
Message-ID: <20190819142908.72082c69@cakuba.netronome.com>
In-Reply-To: <000000000000d917f4058dd525cf@google.com>
References: <000000000000d917f4058dd525cf@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 16 Jul 2019 16:58:06 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    a131c2bf Merge tag 'acpi-5.3-rc1-2' of git://git.kernel.or..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1603e9c0600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8bff73c5ba9e876
> dashboard link: https://syzkaller.appspot.com/bug?extid=23d9570edec63669d890
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13560870600000

#syz fix: net/tls: partially revert fix transition through disconnect with close
