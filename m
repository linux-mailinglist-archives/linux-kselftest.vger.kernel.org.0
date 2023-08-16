Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B213D77E616
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 18:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbjHPQM2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344534AbjHPQMO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 12:12:14 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9FDE2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 09:12:13 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-790b6761117so60493839f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Aug 2023 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692202332; x=1692807132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ml7Avdsp0K+s+IDRpfySD8LfsZQkyxX2I1nAe0mHNMk=;
        b=KnDm8W4GNVKCo3YffmVxkSbPl/peWhH/66l4KbUpxp8xiR3aQoJBJQfJrApS0JHDv0
         v0Ni2/TxKbiA5haP+FdXt+MqPH6nnfynKU+qHilBbdn6C8M1GUo6QkHcUdDcpimGER4T
         4OgCMaA7XhkKTbcAmJiJEZg7TXoUcNuD5FDv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692202332; x=1692807132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml7Avdsp0K+s+IDRpfySD8LfsZQkyxX2I1nAe0mHNMk=;
        b=VEXnpvQEWLDElEbloJDiAj7a27DkcJ+BykRc0znGWjC1Wv9Abaq2FxoqlLjrcHLlOh
         FlkV47iQCqMFSVxIezElMaELrSbagQfPCDC74H085yh6NBoWm8UuU/E+IXS/nS87xtYO
         eOe25OxnDK/sKbM4aBRZ96Dniy9MNatokELyrwcYQl5SgnRsSTP+EQidNTEov5Jd3vHc
         SrGoIW9sXNC6zHjJvFIZnWr2obyylDkcx6LAVQhdHMs2Xx+RMQyqYFaIqI7avJRIUum2
         Ht5lYWtgXu/EZDWLGM59qAz/8obRsPJLuE2mJw2zGfFyVnhMjv/FeQ1shfsFukyL2+lo
         zQBQ==
X-Gm-Message-State: AOJu0Yxne5hff0Rogrd4UqYPy2uv9ElYxuvL9P8aVPQeFvtakZasot+f
        pitvmH5Jff+D+JK4PdtNQJe8gw==
X-Google-Smtp-Source: AGHT+IE8HyobJuBfFiDVV4/Qagzq+NVtrmovBgIE65BWuYxV7zzs9Mj3rx6J0MOuXmxh2AYiCelQHg==
X-Received: by 2002:a05:6602:358f:b0:790:f2c3:2fd with SMTP id bi15-20020a056602358f00b00790f2c302fdmr3730059iob.0.1692202332593;
        Wed, 16 Aug 2023 09:12:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r2-20020a6b4402000000b0079119cfcfb7sm4574036ioa.35.2023.08.16.09.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:12:12 -0700 (PDT)
Message-ID: <38059b04-d822-51a7-f638-34b2795bdd16@linuxfoundation.org>
Date:   Wed, 16 Aug 2023 10:12:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests/filesystems: Add six consecutive 'x' characters
 to mktemp
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Hui Min Mina Chou <minachou@andestech.com>,
        hirofumi@mail.parknet.co.jp, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim609@andestech.com, dylan@andestech.com, az70021@gmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230718034351.1373857-1-minachou@andestech.com>
 <87351lk9xo.fsf@minerva.mail-host-address-is-not-set>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87351lk9xo.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/18/23 00:31, Javier Martinez Canillas wrote:
> Hui Min Mina Chou <minachou@andestech.com> writes:
> 
>> In busybox, the mktemp requires that the generated filename be
>> suffixed with at least six consecutive 'X' characters. Otherwise,
>> it will return an "Invalid argument" error.
>>
>> Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
>> ---
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 

Applied to linux-kselftest next for Linux 6.6-rc1.

thanks,
-- Shuah
