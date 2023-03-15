Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4236BA5E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 05:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjCOEJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 00:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCOEJ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 00:09:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B81BCB
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 21:09:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c4so11010951pfl.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 21:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678853396;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVI227nQg206dumit/vvu6T3g0QgYn1hv/zz9J9XD6Q=;
        b=l3dzOfIBMGXXCfmvFSnEllovOoLtBAni6LZvJww9qVt4I2GEU33+AiB4avATnsCOO+
         yqVxO3quuCYdQ8t7rmTYX0fPe+f059hne/5d7VrFzJwcWeB1ErJRVlnSKUqL0JItdziq
         o+rZ5OcfJJ+luMhrJ94cFXcN0pi+jEiKE/vdHvoIGKnyHaqNVFiES9gxJ+EY5Y5Iydcr
         I5WigLekbTVGgGIVDM5ns7oQHR1S1ak4IapqvigU7IBVViBEw86x8rsy/Et8HMHxhed6
         Jvc9ngjIs+zQs1FsBGBvwgHMsdZdQp0EnETVjJuCkxMIHRy/XP+XjLxPmxF4uboQXJ6X
         GE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678853396;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LVI227nQg206dumit/vvu6T3g0QgYn1hv/zz9J9XD6Q=;
        b=axyS+ZAboomBrMM99kWx3fkNBtTopCmg/Nat2TYadMM8qnbIap9GLSBWtvFrsdT7P7
         NoRmQCY5iuXWF7rROWrgapaQ4W9vmT506pseM3uta7AWtkYtYnapNPejm9GdbxVReKQk
         txqzNhtSEaAR6KBZqh0UztQALKymnCtuNXTY7SQjVsbuPKbYXwKRAEraxpGJPjOT87eO
         T7fJ93Due7vT2Jof/AGpl+XZ3+PewslFBOOvHAjfCPNzVZfG0ii/4VdQcSfV+N9mEYGC
         sJEFB/oRXzu8GkVl/hP6WAr7Q+TUu9rtEpZ7s8fWlg+c8eXS3mhBCVTzuGhA3QnRdmb9
         KXFg==
X-Gm-Message-State: AO0yUKXS/ISp7FBsuUwlpa6Akfxcx9pd6SKyxpKJ4+kFzFzazPVbK54O
        GUv2refdq9IYycSQWXoIPQA=
X-Google-Smtp-Source: AK7set8iReXlMl69mBD4qF+RIbK0WmZJeBj1SCvT/KjiG1lXzpLo3WIoTUJbScNN0GCl35n/QFGJPw==
X-Received: by 2002:aa7:9538:0:b0:622:d84e:846c with SMTP id c24-20020aa79538000000b00622d84e846cmr9430784pfp.10.1678853395914;
        Tue, 14 Mar 2023 21:09:55 -0700 (PDT)
Received: from [192.168.50.71] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id e6-20020aa78c46000000b005d62cd8a3c9sm2391815pfd.71.2023.03.14.21.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 21:09:55 -0700 (PDT)
Message-ID: <f7d58b48-41c6-a77d-2f7d-0df8ea59933e@gmail.com>
Date:   Wed, 15 Mar 2023 13:09:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] selftests/ftrace: Update comment and clean up
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <20230311124151.43691-1-p4ranlee@gmail.com>
 <20230313103033.7bb461ef@gandalf.local.home>
From:   Paran Lee <p4ranlee@gmail.com>
Cc:     linux-kselftest@vger.kernel.org
In-Reply-To: <20230313103033.7bb461ef@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



2023-03-13 오후 11:30에 Steven Rostedt 이(가) 쓴 글:
> On Sat, 11 Mar 2023 21:41:53 +0900
> paranlee <p4ranlee@gmail.com> wrote:
> 
>> Update renamed function comment
>> and clean up indent from 4 space to tab.
> 
> This isn't C code, it's a shell script where editors do things differently.
> 
> I only care that the file is constant in its indenting.
> 
> I won't nack this, but I won't ack it nor take it myself.
> 
> -- Steve

Hi Steve, thanks for the code review,
it's nice to me have solid guidelines a tool related script works.

The first thing I noticed was that the a comment where "_do_fork was
changed to kernel_fork" instead of "kernel_clone",
so I fixed that as well.

Would it be better to send that typo fix along with the other fixes?

BR
Paran Lee
