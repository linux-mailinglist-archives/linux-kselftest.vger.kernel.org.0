Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5A140341
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 06:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgAQFWW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 00:22:22 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:12820 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgAQFWW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 00:22:22 -0500
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BE1293414E3;
        Fri, 17 Jan 2020 05:22:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a10.g.dreamhost.com (100-96-4-61.trex.outbound.svc.cluster.local [100.96.4.61])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E605A341A31;
        Fri, 17 Jan 2020 05:22:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from pdx1-sub0-mail-a10.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Fri, 17 Jan 2020 05:22:20 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Supply-Robust: 370d02ba34fcfd4e_1579238540479_4289310058
X-MC-Loop-Signature: 1579238540479:1777990223
X-MC-Ingress-Time: 1579238540479
Received: from pdx1-sub0-mail-a10.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a10.g.dreamhost.com (Postfix) with ESMTP id 9060B8CAEC;
        Thu, 16 Jan 2020 21:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=gotplt.org; h=subject:to
        :cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=gotplt.org; bh=Yj30kd
        fElzmQt7WZpusShHxwZq4=; b=nM9ZbgrcosXlfUHZk83LH5gID02UM+bTsZex+w
        yMJmbIWxJ/B7sowsTW462lJZqnewEJm5ybsjkPMUdyY63JstvK4KcgcDF8OTNDtV
        4oYybuzlTs7kRCPjGA8NVYVNyi4Po+3r7hFJv2jUoikDhLUJlvLg2QwUkeFT2AtJ
        PnSgc=
Received: from [192.168.1.97] (unknown [123.252.202.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a10.g.dreamhost.com (Postfix) with ESMTPSA id 158898AB48;
        Thu, 16 Jan 2020 21:22:11 -0800 (PST)
Subject: Re: [PATCH] kselftest: Minimise dependency of get_size on C library
 interfaces
To:     Tim.Bird@sony.com, masami.hiramatsu@linaro.org
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200113164158.15803-1-siddhesh@gotplt.org>
 <CAA93ih1KXO5oSKAB6PmQc6xOw4fX5T+2+zx91BD18YUxL+nWzQ@mail.gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF982C37D2@USCULXMSG17.am.sony.com>
X-DH-BACKEND: pdx1-sub0-mail-a10
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
Autocrypt: addr=siddhesh@gotplt.org; keydata=
 mQENBFMAZNMBCACeatEKl6YY9iEVxzS64bPbvJsA1mLE2XFWmKXyYzm58dFqPMa0OQQTKCxj
 FCOrc+LD2KtmypttcahKnk5Lk1lNU/lV2hCuR7jJ37sL+/TFQuMMgsLPED6XU4/AYK3VUJvg
 GYLBnMVfpAGYLB5rnPvhFNx0r2KItO/CfiSEyD4g1Wu26SUAXGOp5hbSyBRGhju+8YJlhHBB
 jn3vZfw7IpwAWDVjK0crqMhGDXoZwK+ADUFY5NERAkT3Lb7d11F6+W4558WQZCYIWa3rZ62d
 986OE7+7xKmJUcLLWvlv5spgUmvotZ4DMzaKba+waY5ygXdGIpm5seVIEUCTaBIe6QVLABEB
 AAG0KFNpZGRoZXNoIFBveWFyZWthciA8c2lkZGhlc2hAZ290cGx0Lm9yZz6JATgEEwECACIF
 Ale0y0wCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEHnEPfvxzyGHUggIAJtLMvzH
 jRQi/Dg6oSMUMPtH7oEmgnk482dC4MGNl/bCtUV7VVIAtEN5TGvHxk1EKBNqj49Q+mZjef82
 iluW1RbXRY6+72yZ380yUC41SY+2hVOurJ//h3nvE+YHfO7QjV97yhIegc1kdwArVtgNNApL
 xj5Nc2epT824uaSznVhwyAS2OIHFLmiMYuIW338uXVEug1XKBHwJ9MppVblk4zapc9fRGvRG
 72ivbTGXNgcza+Kkx1IdA0XB2dEQaAE1XR0FOshKtpeSDRERwZ17+rRT8EjmkRsR7qm1uvPS
 NW7wMTtlj8ox/XuSyG0Coy1NRgqe5bi53ha1kBoKlLaxvyW5AQ0EUwBk0wEIAKELSISlJ9rz
 3tSBPNkpyqwIPn4//ZBuENJQfIWIWYM9r72sBRHZgiilsN7K7g6Ea7vLUVgv5+WInE4PWFQa
 qUSbMubTjshnaIAIeSU0rslwRRqu2B9HmS8marB+UYdQ+MsPVEInrB8uroFf8Jh7h+2Oqs2M
 KUMsayoFyQkVtwh3HI/AMTkmK6iun3AikOK+J9WLQx2Qqf+fLjY5/ZIjbowbd8GK3B4h4kUP
 beUI5TNg6xcKVyxVPMy8HazfaDwlUHfh07K0UFWtaFuw9v3tlaieOTLH0D0cBXyYTAqgs7C6
 6cytxw+Qr6/+uHa8MMREDQwTEEwwick3h0h+vIhCsV0AEQEAAYkBHwQYAQIACQIbDAUCVOqz
 3wAKCRB5xD378c8hh/UzB/0Q13oL/aS8km9sXOa8M1roQ69NUpqpMEOGBWO5naK8wZ2QKh4D
 05DfNa7yT5FgPLI+a4kdOgWbW2fiE/wMYOMivjoFveOdlzPpsew6n2q5/cvopspriCGJWozT
 kwv1dv9gfTKB7dDJt+ICdabp7aohvNi5xeZgM4GxCiO1rfr0Jn7NAR3L5tpQsVD4eDTa9jg0
 qq/EiF+uLQH82D6bsxtS/Xre7b/sTKK3jE6sthui64w7F3X5M1qwk8XCsqCNA1Z2c+zWkLGH
 4ZeB/Rrxapu0H0/TAhBBtbDo665GaRb3NSKzG4rJSjXSEQc4rna/Y7/s3c9uB0yjdyXX08mn HzVO
Message-ID: <cf97c840-70ba-d9b8-6994-0a7ef67b6c0d@gotplt.org>
Date:   Fri, 17 Jan 2020 10:51:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF982C37D2@USCULXMSG17.am.sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtdeigdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufhiugguhhgvshhhucfrohihrghrvghkrghruceoshhiugguhhgvshhhsehgohhtphhlthdrohhrgheqnecukfhppeduvdefrddvhedvrddvtddvrddujedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopegludelvddrudeikedruddrleejngdpihhnvghtpeduvdefrddvhedvrddvtddvrddujedvpdhrvghtuhhrnhdqphgrthhhpefuihguughhvghshhcurfhohigrrhgvkhgrrhcuoehsihguughhvghshhesghhothhplhhtrdhorhhgqedpmhgrihhlfhhrohhmpehsihguughhvghshhesghhothhplhhtrdhorhhgpdhnrhgtphhtthhopefvihhmrdeuihhrugesshhonhihrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16/01/20 11:02 pm, Tim.Bird@sony.com wrote:
> 
> Since the code no longer uses __builtin_strlen(), this comment should
> change also, to say something like "and string length function.
> 

Oops, I had made the change (to drop the __builtin_strlen mention since
the length is just computed inline now) and somehow dropped it in some
copy-paste confusion.  Looks like a patchwork-bot applied my patch, so
should I send an updated patch or just a comment fix follow-up?

Thanks,
Siddhesh
