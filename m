Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF52C701CD8
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 May 2023 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjENKMN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 May 2023 06:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENKMM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 May 2023 06:12:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5D1985;
        Sun, 14 May 2023 03:12:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-504d149839bso2668031a12.1;
        Sun, 14 May 2023 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684059130; x=1686651130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3yluCXcosZrevjCC2JlavkuAfksHzxF5e6l5bTTacBE=;
        b=iz+yyxzRQDLWnoppst1CEwUOmQtrnR+WlvFqDNxHCGjAIeYBxb6qPPyCwACmFvCMsC
         Uyay+Ka36Nybojkh+aNRCqbV3TtPsOyOys25ywg1hMUdPmR2syoQ798Rxs539vYqN85R
         dPEsGL6CYoLfnmNV3lfNftCjnKh5hBzTby0ZGcS3dlt90oaWJqGVnsvzZUmdOiBAhGcx
         cH0+uEO+9igr+IDSq85yTogMKAWP1Judjc/QeWoubOiltGwdbvQx+esnEgsuLyComVPu
         FRS19XpGr1KieeWX8+jraAcOzfBXfZh/EurqECNC853AdiNfIXOyuTn+Wm3pQXS2i+vK
         HOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684059130; x=1686651130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yluCXcosZrevjCC2JlavkuAfksHzxF5e6l5bTTacBE=;
        b=SRgmQkyNXHlsODt7eYY9UMLuxUAEM35kIQE9vUsPXYpRGz5IO/zsXofRwmw84dRFSc
         p4k3Zf34ZGLK83OJm2Nkx+4lcC0icCfcIsGVTT+6gdjxfqOqfuJywWQ0ri6EMQJ0YFLz
         e5FG2KbfHsaztuMayNO+DKKA6Rbu0+UCslFUQb+IUc0HZkguafkihbdbohOj+FM8fhSG
         NLsVWThMn8iyh/tq9ZKDBxjugd/+SpTL5lfeT6RPdSRtAGBfdet5S6wsJhpepKHbsh2e
         JR8pkZg8V7s+EHSgsZgV+NgrzIr+cWK6mghgWtnMr9Wn3xhfQr0LrOUot7CHIOPecBf/
         Vlfw==
X-Gm-Message-State: AC+VfDzWYWxN4ovpsb6V+WbEhc7QX3c8Vw+4FhHSEatdC4nyfIRbQRha
        1G6NgPADuVEnNSO7HrslWMs=
X-Google-Smtp-Source: ACHHUZ53jcFiyqFVZaWmZ6BG5QzdtkqPc0CsOZ7DLrne5HaLi/baHvYx5HM2X79dfK8omAPCsAoDUg==
X-Received: by 2002:a17:906:5185:b0:94e:d5d7:67eb with SMTP id y5-20020a170906518500b0094ed5d767ebmr22162527ejk.5.1684059129775;
        Sun, 14 May 2023 03:12:09 -0700 (PDT)
Received: from [192.168.10.10] ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id v16-20020a056402185000b0050cc4461fc5sm5617797edy.92.2023.05.14.03.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 03:12:09 -0700 (PDT)
Message-ID: <1c4ab661-580c-caf5-f4c5-5a959b410ccb@gmail.com>
Date:   Sun, 14 May 2023 14:12:07 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] docs: admin-guide: add valsa driver documentation
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, perex@perex.cz,
        tiwai@suse.com, broonie@kernel.org, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230513202037.158777-1-ivan.orlov0322@gmail.com>
 <877ctb8e0p.wl-tiwai@suse.de>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <877ctb8e0p.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/14/23 13:21, Takashi Iwai wrote:
> We have already subdirectories for the sound stuff
> (Documentation/sound/*), and this should go to there, I suppose
> (unless there is somewhere dedicated for each selftest scenario).

Alright, I'll move the documentation to the sound subfolder. Thank you!

Kind regards,
Ivan Orlov.
