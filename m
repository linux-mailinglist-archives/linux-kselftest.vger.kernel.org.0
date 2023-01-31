Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED8768296D
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 10:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjAaJsV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 04:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjAaJsI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 04:48:08 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19995FF8;
        Tue, 31 Jan 2023 01:47:56 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id u5so9494067pfm.10;
        Tue, 31 Jan 2023 01:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A655nD9x3a8hHtfO8IDUSlIL069yAfQEg9w8Iv6Dufs=;
        b=m12/umS4j2j0YqF5LiWwgSDuueEjUt9WJxbgd3UcEGFgpncM5fxHeU8fp3pIWJZu/Z
         e8eaJAIjV3VUEKfJReLmAnzxAFEKylpVdbsY03rnbrgtM03mBeX2l7hJ47XWovIFjsyZ
         GLv7z6ni9u0Rg9b+zM2u0BNBUPn4b8jue2pzsnMpYcjRtuioKu7XMNusVeVorDQOq9ev
         hd/ncgcvuu9k5R03+tRwSiR92xMmq9nRmxc8GsWTfh1GHE6Owv6IEUSCCel5QQnvomDH
         Ev63/O/mqL5+Oh9xlNyUibwJXO+EjCC6Z7uO2CNLGM7NxYeDpx3/vh90Q5eyqknrdlMU
         UCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A655nD9x3a8hHtfO8IDUSlIL069yAfQEg9w8Iv6Dufs=;
        b=MRdyzLe3bs/IzBBsH4CnLVVf1vu+v4eOD/rn+nnrNHMkoBcHa+kLpWylDSU0fkL2Z7
         rbYkDuJXncbibxT5XMunS4MKI5ZpgFWi/X3A3cgtssFjsR5wKEwKX/zEfv3aG2dJIXah
         p64/5ghfTgjGTfB6sCw3SH3wtjiGusPFJ/AVPxlH/wmwRX53ak/sruho7npFVbGbFTW/
         61+ji7+5bvniY3ndDzDC1K5tj904Mg5YcCoO4VrdjBjF8vcOCXoQ8p7EfL8+soJ7TsDL
         03UOTQDcSkmYD1GmwukWZ5gs4hUOPk7c0qOF2dTq+shED38Y0DRkVZ4InmqkvsgA7ibC
         zuvg==
X-Gm-Message-State: AO0yUKWEbQPK1IL5OWXVMG7fa/Y5QXdE3ox/eSpbyVdXrCFqvfNUJx4p
        RlV0JWVqE9QdkhJJEvmFhak=
X-Google-Smtp-Source: AK7set9O4tsrz6wug59doXOI4kgE9FXIm4c4WQEycPHDa80z7J04/eOPcCC3ahy+mW4viPWptwCkEA==
X-Received: by 2002:a05:6a00:26cf:b0:580:ea08:5277 with SMTP id p15-20020a056a0026cf00b00580ea085277mr9060494pfw.16.1675158476139;
        Tue, 31 Jan 2023 01:47:56 -0800 (PST)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id j11-20020aa7928b000000b0058bb8943c9asm8911641pfa.161.2023.01.31.01.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 01:47:55 -0800 (PST)
Message-ID: <18068631-d634-679c-3dd1-4493d186ffb8@gmail.com>
Date:   Tue, 31 Jan 2023 17:47:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] .gitignore: Keep track of archived files as they are
 added to a new git repo
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Kees Cook <keescook@chromium.org>, Andrew Davis <afd@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Will Deacon <will@kernel.org>
References: <20230130090426.13864-1-likexu@tencent.com>
 <CAK7LNAT=8Z_-OJdEdUNvUwYpXvWZU7JnYLHW-o+w9GBXjaFbMQ@mail.gmail.com>
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <CAK7LNAT=8Z_-OJdEdUNvUwYpXvWZU7JnYLHW-o+w9GBXjaFbMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/1/2023 12:06 am, Masahiro Yamada wrote:
> On Mon, Jan 30, 2023 at 6:04 PM Like Xu <like.xu.linux@gmail.com> wrote:
>>
>> From: Like Xu <likexu@tencent.com>
>>
>> With thousands of commits going into mainline each development cycle,
>> the metadata .git folder size is gradually expanding (1GB+), and for some
>> developers (most likely testers) who don't care about the lengthy git-log,
>> they just use git-archive to distribute a certain version of code (~210MB)
>> and rebuild git repository from anywhere for further code changes, e.g.
>>
>>    $ git init && git add . -A
>>
>> Then unfortunately, the file tracking metadata from the original git-repo
>> using "git add -f" will also be lost, to the point where part of source
>> files wrapped by git-archive may be accidentally cleaned up:
>>
>>    $ git clean -nxdf
>>    Would remove Documentation/devicetree/bindings/.yamllint
>>    Would remove drivers/clk/.kunitconfig
>>    Would remove drivers/gpu/drm/tests/.kunitconfig
>>    Would remove drivers/hid/.kunitconfig
>>    Would remove fs/ext4/.kunitconfig
>>    Would remove fs/fat/.kunitconfig
>>    Would remove kernel/kcsan/.kunitconfig
>>    Would remove lib/kunit/.kunitconfig
>>    Would remove mm/kfence/.kunitconfig
>>    Would remove tools/testing/selftests/arm64/tags/
>>    Would remove tools/testing/selftests/kvm/.gitignore
>>    Would remove tools/testing/selftests/kvm/Makefile
>>    Would remove tools/testing/selftests/kvm/config
>>    Would remove tools/testing/selftests/kvm/settings
>>
>> This asymmetry is very troubling to those users since finding out which
>> files to track with "git add -f" clearly requires priori knowledge on
>> various subsystems. The eradication of this little issue requires naturally
>> making git-init aware of all .gitignore restrictions at different file tree
>> hierarchies. Similar issues can be troubleshot with "git check-ignore -v"
>> for any mistakenly cleaned files.
>>
>> Signed-off-by: Like Xu <likexu@tencent.com>
> 
> 
> 
> tools/testing/selftests/kvm/.gitignore is already meh.
> 
> I hope somebody will submit a better fix.
> 
> 

If we don't append "!.gitignore" to tools/testing/selftests/kvm/.gitignore,
the same issue still exists due to the "*" entry in the same file:

# git version 2.31.1
$ git clean -nxdf
Would remove tools/testing/selftests/kvm/.gitignore

Is there a better move for this kind of git usage,
or could any maintainer pick this up? Thanks.

> 
> 
>> ---
>>   .gitignore                               | 2 ++
>>   tools/testing/selftests/arm64/.gitignore | 2 ++
>>   tools/testing/selftests/kvm/.gitignore   | 4 ++++
>>   3 files changed, 8 insertions(+)
>>   create mode 100644 tools/testing/selftests/arm64/.gitignore
>>
>> diff --git a/.gitignore b/.gitignore
>> index 20dce5c3b9e0..fa39e98caee3 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -102,6 +102,8 @@ modules.order
>>   !.gitignore
>>   !.mailmap
>>   !.rustfmt.toml
>> +!.yamllint
>> +!.kunitconfig
>>
>>   #
>>   # Generated include files
>> diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
>> new file mode 100644
>> index 000000000000..135d709d2d65
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/.gitignore
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +!tags
>> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
>> index 6d9381d60172..96561c8e06e0 100644
>> --- a/tools/testing/selftests/kvm/.gitignore
>> +++ b/tools/testing/selftests/kvm/.gitignore
>> @@ -5,3 +5,7 @@
>>   !*.h
>>   !*.S
>>   !*.sh
>> +!.gitignore
>> +!Makefile
>> +!settings
>> +!config
>> \ No newline at end of file
>> --
>> 2.39.1
>>
> 
> 
