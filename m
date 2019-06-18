Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2E4A0D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2019 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfFRMb6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jun 2019 08:31:58 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46353 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfFRMb5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jun 2019 08:31:57 -0400
Received: by mail-yb1-f195.google.com with SMTP id p8so5955852ybo.13
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2019 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zjjaR0MJ6NCbQ2tNDKmWvCG8E9amxT1DIK1jQtxlWw=;
        b=PT1Qlvo71aLKxUQwCTqmeZ4N6sNBlKRFpZv3vzbAfnR55ezeV9DkyI+37sHYq2F5+v
         ZI7hAXS9LNNDh7Qgo6PE+503R7wclSAotEkoeINPTfY+bJwjCaALF8kifRkod8xh5TIJ
         STBEIhy1kACDq8eJcufi+agQluKNKJVpns5JosCrupD8uj8K6FGdCY2D0LldV+3JW5VG
         khVDOHYzdZ06h4sGzxQa7XINy9I59z4lA4QbKrCW7TbYUwAdrHPqY7lXA0hk3jBa9Xg/
         2uhhRVYHp4x+15fUatdzO5CtTPGNlWvjC0h7dlZfEQ0PpdQ5mQ16GXimqBx6syysDT/o
         7C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zjjaR0MJ6NCbQ2tNDKmWvCG8E9amxT1DIK1jQtxlWw=;
        b=SmoXS8/Yo/pSPrNnYgxpa2d0TySiXm+s3EpKmN3oNc5cyHDh/TTf3TxwoATbcN5wT4
         9EsJqClkZULDJqvh32vA03h+IkxKhGZNkKrurSsadrnppedRPxpH8G5zc9bjnTuk+VH+
         BAFZ0p+1lRYqO+oBIKHtP1NjfeXWUZlX1Wv2qqIlB+1b4D9t2dqLfhr1yVfdrjIDWMYC
         qdmSPF9Ig7mJxP+eZoJ3mVS4oR+i6/b9M0OlmCF3/qEYeAmru6JsJZrv1hnfd4JpPu7t
         PsR5lqTiXo3FKIYXPc/t8cx3CwifDCmA6OATctUYLzMkughAan0o0TGh8N8WuWbzNkn4
         nF/A==
X-Gm-Message-State: APjAAAUM6eMFvyWv8jRIoLc3Gz9ymRhVnTmQ+Qw4sUwZb4ViTqN4TN7s
        iM57og1t6aOkhiC/HH+c63jsdIGb
X-Google-Smtp-Source: APXvYqy3kV/cXH/fOrQjQNgChVaANAPtvF5C8PyINP9pwqcTLMHHb/oxf+1UBMmeZibsQTviF8kp8A==
X-Received: by 2002:a25:d7cb:: with SMTP id o194mr58978341ybg.384.1560861116018;
        Tue, 18 Jun 2019 05:31:56 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id q63sm4695771ywq.17.2019.06.18.05.31.54
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:31:54 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id i14so2569397ybp.7
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2019 05:31:54 -0700 (PDT)
X-Received: by 2002:a25:d9cc:: with SMTP id q195mr59718440ybg.390.1560861113644;
 Tue, 18 Jun 2019 05:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYs2+-yeYcx7oe228oo9GfDgTuPL1=TemT3R20tzCmcjsw@mail.gmail.com>
In-Reply-To: <CA+G9fYs2+-yeYcx7oe228oo9GfDgTuPL1=TemT3R20tzCmcjsw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 18 Jun 2019 08:31:16 -0400
X-Gmail-Original-Message-ID: <CA+FuTSfBFqRViKfG5crEv8xLMgAkp3cZ+yeuELK5TVv61xT=Yw@mail.gmail.com>
Message-ID: <CA+FuTSfBFqRViKfG5crEv8xLMgAkp3cZ+yeuELK5TVv61xT=Yw@mail.gmail.com>
Subject: Re: 4.19: udpgso_bench_tx: setsockopt zerocopy: Unknown error 524
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Fred Klassen <fklassen@appneta.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 18, 2019 at 7:27 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> selftests: net: udpgso_bench.sh failed on 4.19, 4.14, 4.9 and 4.4 branches.
> PASS on stable branch 5.1, mainline and next.
> This failure is started happening on 4.19 and older kernel branches after
> kselftest upgrade to version 5.1

Does version 5.1 here mean running tests from Linux 5.1, against older kernels?

> Is there any possibilities to backport ?
>
> Error:
> udpgso_bench_tx: setsockopt zerocopy: Unknown error 524

MSG_ZEROCOPY for UDP was added in commit b5947e5d1e71 ("udp:
msg_zerocopy") in Linux 5.0.

The selftest was expanded with this feature in commit db63e489c7aa
("selftests: extend zerocopy tests to udp"), also in Linux 5.0.

Those tests are not expected to pass on older kernels.
