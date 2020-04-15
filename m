Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C835E1A93E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 09:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404624AbgDOHNJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 03:13:09 -0400
Received: from mout.web.de ([217.72.192.78]:51619 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404013AbgDOHNH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 03:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586934741;
        bh=EXAvT0aboByTL0/9t4BjG/IsA2KiGVphpaH4RvWApW4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=So5gXrdAlzClyqiPHjA1axpMsZfSIMgAQGCjGrl1IxqOU4MDzSNZ7hK8hm8PNyXoC
         qrmGMGujEWMyzvbJdD3/0qLDRtvloh63u8nD6hLYiC9GJUKAjWte9M4i6lF9W5fioN
         TNG2k+pHUdrYM5OMy3RVEosPHAH/RpbSqmkNKI8Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.133.192]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZvgf-1izQoy2TcL-00li0R; Wed, 15
 Apr 2020 09:12:21 +0200
Subject: Re: [v2] tracing: Fix the race between registering 'snapshot' event
 trigger and triggering 'snapshot' operation
To:     Steven Rostedt <rostedt@goodmis.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        linux-kselftest@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Xiao Yang <ice_yangxiao@163.com>
References: <f4e4614b-e3df-e255-42d0-1148e39b3f8a@web.de>
 <5E966604.1020400@cn.fujitsu.com> <20200414214643.2e14ac76@oasis.local.home>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3797d4b4-180e-fb25-09ed-888385c04894@web.de>
Date:   Wed, 15 Apr 2020 09:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414214643.2e14ac76@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hcxfmI3274wXkvaT6yq+7njR+vADLySKx89ZAvKUd5j/eoFHF/E
 dst47aSvxB5eCVS/aBuXHy6+v/p5MGFb7offiTWK11Oyba8Lp2ZRnyqet8cNZV4m4AanTe5
 My7dRCoQzHLK8sP5RH67IRg/yZYU90PaIfQzsmzhWfrEpklbvIHKGIC2U7UAmcjQoBH9niW
 ach2xOx5CErUN0h7oabmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RLDtb7Oo75U=:u/3ry2wzTv2PP2x+FI8Td9
 SsyZwNT/LVsu0g+N4cBXMhXzUIxMMLzGDQrh0MrcfO7dQkLTxDU4eiwGY7Vop4fw4T27ev7Wt
 0zeSXbJUQGrDtJfYi4Cg1A4rd0m0LFX4S+URGawibcmh9v5P2S5Km1cYghDm//D+nCSZohqbV
 Htk9iziOh679wq7b6FO87jHf+cHofORphJqOYFIicO5/fZtnxNOsFeLXVDUytMbzM6zwvMfDQ
 XnNEOx3PrURIuaVc0uETlXhu4cJlT7iPtqma5ZHKQden2wJyfPfuqwda0hgUMfkaM9eEt5IG6
 hkcH62J+SSbPCjuNMLYBsfEwri3T53WaWUmoAft2YDw2myxQCfxJlcjw9gkvhwAbqonzHvnWs
 OC7IYzRQdnNRnlhJcsyD/L4GZJRaT+x1yP5ma83dRYKBn+5fJ64ZEz68n0qBGCsmMx9LvttZt
 CHJ0xFZEdkEaWL5WNRbfhdRv14pvanxADl3bU4EZrNrMIs+btX++VHuEjEo/TI8NSMauFilqb
 z8vRsoYUsStpJHKN7r87q0a6pcVaNlxPflY78G2yvGK7o8UWQpnoh9v/9PdONL8Wr60yWDjKT
 TnXhOoDltVaIRNeTfwNJ4XJ4ZDoZc6elYOPOdR0iiVcC3XC1uv13QbTABH4dAad+2brffPp5N
 Q1xhakqxWsaHz/Ww/cLq+NA2M7CSUsxZSYcDBZIpKLlWdg0tD2q4IMk7F2EvX8+edWssWxlU4
 rreenxlaRGE+xmtceJ2w68WDVVhHs1xRYG7R5vJJwlS1Ma0F2ZF9/4OKCvf+IfDCCpQF9/LTy
 f5gVYdOMms19iY0sWfQWq6oE4v2PAgLdVOhUYDZIE8Wo1LhrPCyhrrm7BHaHRtNvHQcFVDTt3
 aLtgByYRzjGoZaK2vWDXPJpgRjTlEvHnhaHS/txFxwxR15J5F0tQsjnbhdTOwei2HtL/K8m0K
 s+m6eKHXRlrXoFuLzS9GYx9gPI2Xwtp4mvAmJca0MG6j04V1C/WhhLiaz9AKlak482wLa9L3F
 DkCb02m81xoijftzCaDgm7su11pp0aiozE9uAHC61dl2ryCADt6mZB+PO0liq1gq6TpvX1Sm5
 PMlgsqT/gApKEXV3RioUR8ASZJS1azxxpdjOyX69DZ5BfJ1t3ISXA8MdMtxIOxB96svxyOuxQ
 q97b7uPViEKWFwrmlvh0S5PlBHFxFppEb+Sg08o3Ele83cz3LJuHa36rYcc80WxlpwHE3vH6b
 iALMgqSNHnhxXMJoq
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>>> * Adjustment:
>>>    =E2=80=A6 operation (i. e. =E2=80=A6
>> Hi Markus,
>>
>> Which part of description do you want to change or could you provide an
>> example for reference?

I proposed to insert two space characters in a wording.


> That part is fine for me.

Such a view can be fine if you would like to adjust the provided contents
another bit for the final commit message.


>> Do you mean to add the following "Fixes" tag?
>> Fixes: 93e31ffbf417 "tracing: Add 'snapshot' event trigger command"
>
> Yeah, that fixes tag is appropriate.

I suggest to reconsider the influence of parentheses at such places.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D8632e9b5645bbc2331d21d892b=
0d6961c1a08429#n183

Regards,
Markus
