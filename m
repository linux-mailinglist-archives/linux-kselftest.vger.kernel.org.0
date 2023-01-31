Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B81682FDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 15:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjAaO4U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjAaO4P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 09:56:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0564902C
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 06:56:14 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B6EF41ACD
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675176972;
        bh=AlB8b05C7dVOUoHfI5LwN6EaAU6Zf5saWzPt6nZK+Yc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=cCc5IE6XuQwyMNThxFG5a0x8spk8BXhKPVd00yTCAZ+g4fZMGaxqQsW72TNKH0ORu
         x8bXhjHxos1+GpnzTCNy9w1fuFeYEfGCNaxvXxVyBPumgJOp8bWuNkn/mhEdv2G4u9
         E8jLNO3Uf5ODDRCAqg4ewM3jnIsUiBpbBcqDuKMtnfG9yz5TqYq/MVdl5AT45TuSQF
         lm24O5I/HgDqVaOUzDoPYs+5JKMK0jq7DucP8Le1sR50sq/b5deLSNm/5tK73cLjjP
         IeNRFHrDNOWopmRMO/cJdBdcC45Rl8pYc++zJTDKiBe2KLenUBmPVfhDMIztMlp0CZ
         nbqwBgkGY18ZQ==
Received: by mail-wr1-f72.google.com with SMTP id v5-20020adf8b45000000b002bde0366b11so2525759wra.7
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 06:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlB8b05C7dVOUoHfI5LwN6EaAU6Zf5saWzPt6nZK+Yc=;
        b=bk//3UDpZOuLI/MFDW1eX/tV21S3yPJCUZC5iwNn32MLAIn0r5gLz4U3KZ2QBnYyOC
         wVyWHUswN0qKcJiZ+vzwQvkkcy6JI3ufWRUWVDhyYrT4wqkszCLktrzkjct+V7WNmBeV
         GafRyDVL0rkdMtlWb9uZrv+MkOZBC831ZwxjYvlh5RDpk7T+DG3kJi4ltCKF3/zdF69Y
         xwAssDRQ4lyMUX3I+FDugq9eSySs/U22k9OCFTZfgC4UF0xY86KCzPJFHfUuIzSWGsKL
         Jzd+X5Fca1B7YyyXvB6f9CHlNMk6o5MejX3cZF86FiHhT9lG5ve8DnBykZ/seDitxugt
         HCWg==
X-Gm-Message-State: AO0yUKVToJoynsJMyLk6GHaK8WS4aZaYyF2tJe7jG4LR9rNRWgOoShTf
        SIY43GYonypVIeL3SPKK6nhC7iuhDgxLMC3Zif476SAp8hq2rX4WYcNpPzqVAjMswDpS5HEDI/e
        7OhhiIobp0uoHbqJMRr8WhoMycOHOCbkhejTe2PZoMAPLow==
X-Received: by 2002:a05:600c:a383:b0:3dc:5d34:dbe5 with SMTP id hn3-20020a05600ca38300b003dc5d34dbe5mr6345462wmb.28.1675176971549;
        Tue, 31 Jan 2023 06:56:11 -0800 (PST)
X-Google-Smtp-Source: AK7set/kmTg66+6xZhB9GxMFug/z6IY44Vst6FoS618jTLnJhc1ZwpeLLGGR28bD3tr9Ut5PwFVgSg==
X-Received: by 2002:a05:600c:a383:b0:3dc:5d34:dbe5 with SMTP id hn3-20020a05600ca38300b003dc5d34dbe5mr6345437wmb.28.1675176971259;
        Tue, 31 Jan 2023 06:56:11 -0800 (PST)
Received: from qwirkle ([2001:67c:1560:8007::aac:c4dd])
        by smtp.gmail.com with ESMTPSA id v2-20020a05600c214200b003dc4a47605fsm11003906wml.8.2023.01.31.06.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:56:10 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:56:09 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     Willem de Bruijn <willemb@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] selftests: net: udpgso_bench: Fix racing bug
 between the rx/tx programs
Message-ID: <Y9ksCeMOkvyHkc1g@qwirkle>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
 <20230131130412.432549-3-andrei.gherzan@canonical.com>
 <CA+FuTSdtzFXWWDLk=LOdrkS00oH4HGvtoYYQh7YQd2ADsp0UbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSdtzFXWWDLk=LOdrkS00oH4HGvtoYYQh7YQd2ADsp0UbA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/31 08:33AM, Willem de Bruijn wrote:
> On Tue, Jan 31, 2023 at 8:06 AM Andrei Gherzan
> <andrei.gherzan@canonical.com> wrote:
> >
> > "udpgro_bench.sh" invokes udpgso_bench_rx/udpgso_bench_tx programs
> > subsequently and while doing so, there is a chance that the rx one is not
> > ready to accept socket connections. This racing bug could fail the test
> > with at least one of the following:
> >
> > ./udpgso_bench_tx: connect: Connection refused
> > ./udpgso_bench_tx: sendmsg: Connection refused
> > ./udpgso_bench_tx: write: Connection refused
> >
> > This change addresses this by making udpgro_bench.sh wait for the rx
> > program to be ready before firing off the tx one - with an exponential back
> > off algorithm from 1s to 10s.
> >
> > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> 
> please CC: reviewers of previous revisions on new revisions
> 
> also for upcoming patches: please clearly mark net or net-next.

Ack. I'll do all that in next v.

> > ---
> >  tools/testing/selftests/net/udpgso_bench.sh | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testing/selftests/net/udpgso_bench.sh
> > index dc932fd65363..20b5db8fcbde 100755
> > --- a/tools/testing/selftests/net/udpgso_bench.sh
> > +++ b/tools/testing/selftests/net/udpgso_bench.sh
> > @@ -7,6 +7,7 @@ readonly GREEN='\033[0;92m'
> >  readonly YELLOW='\033[0;33m'
> >  readonly RED='\033[0;31m'
> >  readonly NC='\033[0m' # No Color
> > +readonly TESTPORT=8000 # Keep this in sync with udpgso_bench_rx/tx
> 
> then also pass explicit -p argument to the processes to keep all three
> consistent

I have no idea how I've missed it. It will be in v4.

> 
> >
> >  readonly KSFT_PASS=0
> >  readonly KSFT_FAIL=1
> > @@ -56,10 +57,27 @@ trap wake_children EXIT
> >
> >  run_one() {
> >         local -r args=$@
> > +       local -r init_delay_s=1
> > +       local -r max_delay_s=10
> > +       local delay_s=0
> > +       local nr_socks=0
> >
> >         ./udpgso_bench_rx &
> >         ./udpgso_bench_rx -t &
> >
> > +       # Wait for the above test program to get ready to receive connections.
> > +       delay_s="${init_delay_s}"
> > +       while [ "$delay_s" -lt "$max_delay_s" ]; do
> > +               nr_socks="$(ss -lnHi | grep -c "\*:${TESTPORT}")"
> > +               [ "$nr_socks" -eq 2 ] && break
> > +               sleep "$delay_s"
> > +               delay="$((delay*2))"
> 
> I don't think we need exponential back-off for something this simple

I'm happy to drop/simplify. I'll go for a simple sleep 1 in a timeout
loop.

> 
> > +       done
> > +       if [ "$nr_socks" -ne 2 ]; then
> > +               echo "timed out while waiting for udpgso_bench_rx"
> > +               exit 1
> > +       fi
> > +
> >         ./udpgso_bench_tx ${args}
> >  }
> >
> > --
> > 2.34.1
> >

-- 
Andrei Gherzan
