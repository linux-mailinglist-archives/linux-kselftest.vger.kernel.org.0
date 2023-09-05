Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAD7927F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbjIEQH6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 12:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354784AbjIEOWW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 10:22:22 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C91194;
        Tue,  5 Sep 2023 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693923725;
        bh=HENdTPz9DKLgwbLK0xXsSzaRwMyikMlHnYMJdwmq++0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=H7EaYOp5egAJsKwnA8munvzl9JiKOzBwhRK8/WJHf+uurhgJdAZG47SHzkELlCTwB
         JpP1Bod9ZPJf86/SDiJmNYzwwJItNk42oS6MIi5iDp75H9VGP5PjFfAUEK3rlxiIL5
         9TvPGp4gqOwNdpfCQmzOm/DznxiW/b1PqcSNW/jc=
Received: from rtoax.lan ([120.245.114.157])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 580046EB; Tue, 05 Sep 2023 22:22:00 +0800
X-QQ-mid: xmsmtpt1693923720t1sy3uo3k
Message-ID: <tencent_2D10CB0CD885A8B2A42EAB546E5EEF467B09@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS5ZQPGHX+/hR4HEKI2ljXem8GivFomlSl2eDzLj1NiT397Jr5pD
         8nI9TJ9PMGRcMnU/o/lcNJwmB8eE3spPvl53RKPPydsXy2XxmhL5Xbo6b3tyLa3tm6GB0twTnT1k
         XnCeFIYs5MvEvK9rP3UvLqdIy4EBciqWWabXZNCrwQ6M68HyrKvBPzaNSX5ChOyk55iPAKs/MZgH
         NdLJbxm7G9auXiRPutnh5FyX2qJYWYWwxOqZUZfMIMMS1M0W6sJV30RAevtPiC+EYnI5RQ8N7pDq
         dlNsmW4rJNQwYL8cWyPLLXaslEbu51mntl4vGEXxiSidInFK8RUo1+7zEM/k3qSq2owg5iOTcleO
         kNDEqHXtSn6aUB3rpWUTslfqXNCPnZv3zkNaeY5UDXdK7jf3bW3un6ApZnVs+j6BqCX+T4SbiLWF
         wKfoTpO5FXTHQUqByPMnE6Lcq9ELoZyK1PK+LP6ZOPRdnI4CUtF7CufpFUGpxW+0JtsdmYWt1UOa
         Ptdj9W33+EJ9qtwDOy3D0ifyoQBuzhTgm56Fwe7glclWed0OyGYfYaIGWdVe8KBLhgYMWRWBB5I7
         eZQ3bWBqlIpkdmMA8Nz+OwHoNV4+J/vej98+WtOV8C8RYfzrwOaLMf5xEqmf83gpWV4vJ9LCJs4W
         OuMcEzmX/3JOzG/VHst7kryEPYYG8d6IKSMPDwzJnhyAL68Z4HBYRTKiL47KSA7GKR52DAaQuc7m
         DbTMchSTmwiU7lPjevb7ZUMD4iTYgbneF99Xz/ujZWLreCzVNqvURl6lRSB94n3/cFaTcTEIBboc
         PvOOIhw/pDwjQkw+3M3JmAvxIiIIQDvkGLJreVYhIcqJBHtHqIe/8ebzngGeivwt0B1kPhhygoUH
         lnav8x5/yOs8CfwhhkTRbXm6RdrFBE/ES5gUmRhGlq7aBmlOHExNAGcoUOf1TFpLaCLuKxSowxu8
         3kYG7KvR6ysnbGGiGoohMCNtb+DV16G0GJuaUybFE0xUPATzDfsiDAk83DnYqmp/yhq3e4jsyoV/
         mByZ4qvFfYoRjGczcwKdFEysvUroc=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Rong Tao <rtoax@foxmail.com>
To:     olsajiri@gmail.com
Cc:     alexandre.torgue@foss.st.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, laoar.shao@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, martin.lau@linux.dev,
        mcoquelin.stm32@gmail.com, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v10 1/2] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Tue,  5 Sep 2023 22:21:59 +0800
X-OQ-MSGID: <20230905142159.114458-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZPY1Lu8341L+d5Rw@krava>
References: <ZPY1Lu8341L+d5Rw@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, jirka.

I just fix all your advise[0], and submit new patchset v11.
please review.

Rong Tao

[0] https://lore.kernel.org/lkml/ZPY1Lu8341L+d5Rw@krava/

