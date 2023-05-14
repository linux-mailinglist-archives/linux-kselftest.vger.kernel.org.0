Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C73701CD3
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 May 2023 12:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjENKJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 May 2023 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENKI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 May 2023 06:08:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC001171B;
        Sun, 14 May 2023 03:08:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50c079eb705so2851915a12.1;
        Sun, 14 May 2023 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684058936; x=1686650936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ie9tiZWx0j0qso2N+/tHJUjGfMip0OumDCuv0l96kj8=;
        b=WgvlRw8uZZxNk/hWPkNXit0p+MkX0JNCyI7Vzy7yJY+OsvwTCNXVGUhs1wWVsvUX21
         nXH/U8P2buAlKk/QRUpPPlXwZ6xNSMN6Ie6c/P8o7+U+TpPiXqw9cHPQjufjQaP2oH5Z
         2ogGG7SzwoCreXK0QZcfN8Vr/5p2DNlO0+EVTN8Ri05js0mr8AoxvR+iELR9nMwsZ3eX
         0jkh0jQ8AObDYgvzUWBh6JBIamixp/DoIj7xEXrCplepepbHVOhrtVNq1s6jsaAgz15J
         6aPjtcKnlAQO8J9gHOrvTKum+grQaRuZiDsoQgJQpFsjgWYa2kNloSVD3NMmgFoodj29
         ZKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684058936; x=1686650936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie9tiZWx0j0qso2N+/tHJUjGfMip0OumDCuv0l96kj8=;
        b=bHDm9wumCfVyGgQReF+RGNFgmnjl3qnjZwrTy+6aXPeLIedziqqVhXvDghAzA3CaiH
         Bs2ARKK7oZf3q47zuEewP2K/fKa30Td+gdMNevNpSQOxl7GUBXnqMxY3uey2tEDHFvhm
         g069sym6jgAKnAhavdpKm3uWhXNhPstXLsnaqUpMefs1OI3NCKbuIDQHFCOsqe8c33+s
         JSsujAJ1iSb20sGC29HgzoXsvG88WZkTSuu6Y6Ad5UIs2u+pZ3mEtpawrn31gWgATzo3
         0oaR0FeM7hYGzgL9Wb3ktsKx+SYnpTEIS5b6HQP5xsbjHXWrLdFKK44rpIiPvpW5eo9F
         hUOA==
X-Gm-Message-State: AC+VfDxsCgP5mg4Tye2DgKqeJO7n+sIA2qVNaKrSvVSNS0wmyfXF535x
        nw8CqqdgB96XQHm4nnpLYow=
X-Google-Smtp-Source: ACHHUZ4Z1zF+di5vZ/CeRoQGRNuzAxlt2n8nf6jgaD78i3qq9gsh34Uq5xlThiik/oqT/cdFYmGmmg==
X-Received: by 2002:a05:6402:2742:b0:50d:9ba4:52dc with SMTP id z2-20020a056402274200b0050d9ba452dcmr4516415edd.0.1684058935703;
        Sun, 14 May 2023 03:08:55 -0700 (PDT)
Received: from [192.168.10.10] ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7cd51000000b0050daa883545sm5679306edw.64.2023.05.14.03.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 03:08:55 -0700 (PDT)
Message-ID: <6f6d09b3-39e7-58b6-221f-6276d3ce213a@gmail.com>
Date:   Sun, 14 May 2023 14:08:53 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] ALSA: Implement the new virtual driver
To:     Takashi Iwai <tiwai@suse.de>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, perex@perex.cz,
        tiwai@suse.com, broonie@kernel.org, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        gregkh@linuxfoundation.org, himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230513202037.158777-1-ivan.orlov0322@gmail.com>
 <20230513202037.158777-2-ivan.orlov0322@gmail.com>
 <878rdr8e5f.wl-tiwai@suse.de>
Content-Language: en-US
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <878rdr8e5f.wl-tiwai@suse.de>
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

On 5/14/23 13:18, Takashi Iwai wrote:
> The idea is interesting, and it's a definitely good thing to have.
> 
> I wonder, though, whether it could be better provided as an extention
> to the existing snd-dummy driver.  The advantage of extending
> snd-dummy driver would be that it already supports different formats,
> etc.  OTOH, if we create an individual driver, the pro side is the
> simpleness of the code.
> 
> I'm inclined to go with a separate driver, but I'm open about this.
> Maybe Jaroslav and Mark have some opinions?
> 
> About this patch set: the driver name should be a bit more specific,
> as this isn't a generic virtual driver that is used for general
> purpose but it's only for testing.  And it's only for testing PCM.
> So, a name like snd-test-pcm would be more appropriate, IMO.
> 
> And, we want the coverage of different formats, channels, rates and
> accesses (interleaved vs non-interleaved).  How can we extend somehow
> more for that?
> 
> 
> thanks,
> 
> Takashi

Hello Takashi! Thank you for your reply. I fully agree with the naming 
issue, and I'll change it in the future versions of the patch set in 
case we choose to have it as a separate driver. I also prefer this 
option because in my opinion the use cases of these drivers are a little 
bit different. Also, I believe I can extend the driver to support 
different formats, channels and accesses in the near future.

Additionally, implementing these changes would be a perfect task for the 
end of the Linux Kernel Mentorship program I'm going through :) However, 
I'm open to other views on this, and I'm ready to move the functionality 
from my driver to the snd-dummy in case we prefer this option.

Thanks again for considering my changes!

Kind regards,
Ivan Orlov.

