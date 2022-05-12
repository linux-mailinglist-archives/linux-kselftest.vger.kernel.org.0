Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC1524543
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 07:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345070AbiELF7W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 01:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiELF7V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 01:59:21 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A73421AA8F;
        Wed, 11 May 2022 22:59:20 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id n6so2851745ili.7;
        Wed, 11 May 2022 22:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=i6sSIotdIWouqlURKWF/odLlAcLzJKzrea0b/RTwDAQ=;
        b=baKvNss1FgFVPquDs+enoki70l8DphZzft/UeT78trhXzx1hh3DoaeloO6ZK2puzgt
         Zffybs5INr7xmPldsidZ4DMKUHwfXgSfsM6c2dhE5yrRCHFtlIyPGMnP/p85VosDvhYi
         H4k/F3BPqZptVb6/pTJe/x9QTie2iL+/arsFJjdORZvKxRPPFiHKxdUEglafIBQy1aN6
         RnwB509eU8/hEzN9TgBCw3LnvXQKGR6B8uuJUmoLiI13v40XEMrawP7omD5THim1eTTe
         7+JK6aUDASQmfSa6pG8Qr+bjsOafTBO/aaWR+4BTCUvGFrNQVXJ8Mk9PxcUwXk0FerWL
         9mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=i6sSIotdIWouqlURKWF/odLlAcLzJKzrea0b/RTwDAQ=;
        b=t3kmjEPTJxAV/6Z4rqi8UJj7WZX72bwRBlN1RX94AHGYj9NrsZYmC++wuRlOo7lBEb
         2DIWy3PUwEi+PRZ3bJ3Vv9JxM+vVYIPNQcC0i/JP8ad7Rjy3s/n7NiCHM104dkctgK3g
         ZPY1gE/s6t8h4LcmDvsJOcHC8Kt3F1fyZWv6WXzdlAORXthdxqEt0NFpRMfX/gb5lkwx
         l+M1xw25pDpuSsny9NNX+eeA7gp7KqCjxwXYbFnKg8M7cdHFbHM24AEXZqki16CM1sMx
         UDSh51tNCWS2di30mJ+Dy42Hru8gYxWWAOlBoj5o0zwrVgobAy6ttH75e8h+GfTxPEcN
         smOA==
X-Gm-Message-State: AOAM531y5IK715Zxosmu7D7vi24lrXYHU2l416lEOak7gcTXae3Tn6mG
        Dgbu0tCkXnflkXVOLeq6nvs=
X-Google-Smtp-Source: ABdhPJwJc/133PL3/MkHui2eEbGZKlk1DxaQS1ki/TTpZHhP1e4OCilxlH0XBkf1X1VkMxOaotgzcQ==
X-Received: by 2002:a05:6e02:f11:b0:2cf:7745:d4a with SMTP id x17-20020a056e020f1100b002cf77450d4amr13517811ilj.313.1652335159828;
        Wed, 11 May 2022 22:59:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:fdf4:a10e:cb39:9b64? ([2600:1700:2442:6db0:fdf4:a10e:cb39:9b64])
        by smtp.gmail.com with ESMTPSA id m17-20020a927111000000b002cde6e352c6sm1159994ilc.16.2022.05.11.22.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 22:59:19 -0700 (PDT)
Message-ID: <bc6e9ed7-d98b-c4da-2a59-ee0915c18f10@gmail.com>
Date:   Thu, 12 May 2022 00:59:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Frank Rowand <frowand.list@gmail.com>
Subject: [RFC] KTAP spec v2: prefix to KTAP data
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the middle of the "RFC - kernel test result specification (KTAP)" thread,
started in August 2021, Tim Bird made a suggestion to allow a prefix to the
KTAP data format:

> Just as a side note, in some Fuego tests, it was very useful to include an identifier
> in thethe prefix nested tests.  The output looked like this:
>
> TAP version 13
> 1..2
> [batch_id 4] TAP version 13
> [batch_id 4] 1..2
> [batch_id 4] ok 1 - cyclictest with 1000 cycles
> [batch_id 4] # problem setting CLOCK_REALTIME
> [batch_id 4] not ok 2 - cyclictest with CLOCK_REALTIME
> not ok 1 - check realtime
> [batch_id 4] TAP version 13
> [batch_id 4] 1..1
> [batch_id 4] ok 1 - IOZone read/write 4k blocks
> ok 2 - check I/O performance
>
> Can I propose that the prefix not be fixed by the spec, but that the spec indicates that
> whatever the prefix is on the TAP version line, that prefix must be used with the output for
> all lines from the test (with the exception of unknown lines)?

The thread was discussing many other items, but this is the one that I want
to focus on in this new RFC thread.

Tim's original email was:

   https://lore.kernel.org/r/BYAPR13MB2503A4B79074D8ED5579345DFDCB9@BYAPR13MB2503.namprd13.prod.outlook.com

There was one reply to this that commented on Tim's suggestion (and also many
other items in the thread) at:

   https://lore.kernel.org/r/202108301226.800F3D6D4@keescook

> Oh, interesting. This would also allow parallel (unique) test execution
> to be parsable. That sounds workable. (Again, this needs LAVA patching
> again...)

I found Tim's original suggestion to be useful, so I have come up with
two possible ways to modify the KTAP specification to implement what Tim
was thinking about.  I would not be surprised if someone else has a better
suggestion than mine, but I will reply to this email with my two alternatives
to start a discussion.  My alternatives are not in the form of patches, but
if discussion leads to a good result then I will create a patch for review.

-Frank
