Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19D0779D7D
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 08:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjHLGHq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Aug 2023 02:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjHLGHo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Aug 2023 02:07:44 -0400
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92730DC
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1691820461;
        bh=or3m7nDVbGslYKzNBGJsgMwYV83c7TsMpnk2lv2GMYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wdYwB6IoSuOjfzl70UpHHuhUJ6l1SZEvPY94y0T6UFJk0bukZStuk1JEC8CY0RZxX
         XgT57MX6uUgOYQGTX4STz5qzfJCynCwCXx/P7MqwOdm0gPMq55aCANBbo8Bxtf8NI0
         U2bzuJeBHvqYHwGtnecKdWQw2vT2sx/dQp/a4HG4=
Received: from localhost.localdomain ([183.197.149.136])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id 1E587479; Sat, 12 Aug 2023 14:07:37 +0800
X-QQ-mid: xmsmtpt1691820457t7b8ig2in
Message-ID: <tencent_E52F63546A5F4B466B10ED0CFC84A2B3A009@qq.com>
X-QQ-XMAILINFO: MBREESna/OUi9ADhPBWRzPRma+A9r8UB1g2+70ILjPcO4XJQ4RaN9OVHdsOHf9
         nsjqZ/oWVV3Mt6z66SD4ROp1EDBouQtTO5ZFT8KB2XRNAM2eFJ3UKAN67KsHPBbRZuiviKDsQ9ex
         6LvYMBPJwYsnvlKsu0Qw4mIKfHrw4ph9KoFQ+m1CfxzO0une2fCNGL9kg5DCOSqRm9kpFCiQrQf5
         pipg5/4v5qr205hh/KhhsGl27f3i6B0B1dj6e8jL/nNWYqXYiobcaLNcIN25BoGnbze3YKGLr5CR
         DQ7B8AyKidzZ4+LEALjNDuDd95RsR5mgWAjCV1EVnvSaQd/+mj2h3gGdOZprlM7kBlYbQRm09Ogv
         qDiCQ90pN/lOkH9+xmvarqbh2X9YUgzzGv9xZTqUy861F9MS3v/yIT2U6ucTPdDn6s+queHvvyhG
         siii7gsxFvtUk4nhVn3yMCkik/MQ+rKouXzzfUjcbuxMc/tJk6v/nQhssUuXrzSL+IfJKWlF3aAK
         N9AOWVpeGH8BihEqIpHd6WpwRAE6RU+lbTW75yTNPffsYVbCFCMC1ngdJIkMc/MTndL35D743XE8
         PA5l0XZKx8N8RF4ab/LwBS6vOfxJZnXctGCogNKbmgWey26z+d4g94LNRM8XByJ1SCy2yoizhFQ0
         h8/nol7DcdaXEQ9S/8mTwVITnj/xC5gasjN4EwEmVT8hIPblRk+keDrSKK4dHl74vnm3ssMu0yNk
         1fxl0O/WuyBOLQ9tmxZul/mg7l51st2vmT4m2YSavSOcjwwfx/xyJw7WKlvYeXOqc+snQ/c5N4X7
         HsRJqEJe4N5zJ8rIJNLruhaz4LuW1sRFPnH+lSlrDP7g99dbHcWMpOG2GZ6YHuSbZS7V9P/gqOlh
         QqhEJC649KXAXIvW0Vxhz6mYdhVSIeqy+7Uowu1R+NoheP7bTHqHGHHLw+msCLBnsIcZBRJPZDC9
         JlDKkutCdSUNceoGHDpIKXBSUPrWzaNcseaT7Oe3CeGdKAcdq9pMt1geWp06g4b0uH2vSVKIHmj7
         2Zb2pG1Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Rong Tao <rtoax@foxmail.com>
To:     sdf@google.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Sat, 12 Aug 2023 14:06:19 +0800
X-OQ-MSGID: <20230812060619.7684-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ZNZq76jCnzNy7QVF@google.com>
References: <ZNZq76jCnzNy7QVF@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I just submit v3. Sorry, I submitted the same patch [0][1] twice by mistake,
please choose one of them for review.

[0] https://lore.kernel.org/lkml/tencent_89AF48A3CA88040670422959BB97062A2408@qq.com/
[1] https://lore.kernel.org/lkml/tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com/

Good day,
Rong Tao

