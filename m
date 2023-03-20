Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F026C1E98
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjCTRwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCTRvo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 13:51:44 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472B131E22;
        Mon, 20 Mar 2023 10:46:02 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 64594541B01;
        Mon, 20 Mar 2023 17:36:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AC63D541B75;
        Mon, 20 Mar 2023 17:36:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1679333762; a=rsa-sha256;
        cv=none;
        b=PIAShpVwyvpJZnCyPWAogg0YGrBqfZEm4Q+ZadyqsY3jqC+TKlBiW7CiNi8HDs199z0HhL
        UZDTTWMybXaSZdlpfS+b4rFyWxrRztP3AN3eA8eiNRYbCiUdeLGMf1i2JAQabBOv3zONQf
        zqbcqYK6hJpBZc4l3ktthB66XdXX58AEkOatFAt4Xl9BlNMy7YEfCA9yRU5ZN0kXvF307a
        KShaNtSfMOqOwbLTW+ati2ek3euuO5WO4Iu2Mjhq/l7JLRH/wJqsasnO4JEGOmvAlBNxvS
        E0sXrMTkgDtlkxoH+RmDoRBvv+RPfUOtNIFSLO9OcqwL7jWFDJLrpgsKU4cG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1679333762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6cUWCy5BondAFKhr1G1eG0K7rK06l9QCNh+5bql75bQ=;
        b=n2tZs5125yPkZ3CNlnlmBdUkXF+A6S55sIFIf1EIqfNvNGAwTVqkgl1tbc7k9PeZP0kXal
        Qzd4+wzB8mc2cbswJjOJhKMOxUhCRt+mY8c6E2ef6iGeSf49rEYdYqDG/36qdnHFGQcjwf
        /53eS7QniZWeYhUNWAgyYRRW2NwNIXzEpTosK1soXulqq7LSG/BKtUATMO4bUE7kHodfpi
        QTaolxWC/XVJvnMhhyP9pH1q+HO2sd8ygbAMr3NhyjMD1yhIG/7rr1Ud1n7DyZWieKYC9O
        uoz4OvRlwJ9010bLz6bjkMSvRmfEpa//K57cqegAgbxpu/y3oJgJDzNICU0PSA==
ARC-Authentication-Results: i=1;
        rspamd-59dbd69698-w6jh5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Vacuous: 42b4d09114e22d43_1679333763159_1412504491
X-MC-Loop-Signature: 1679333763159:3813855172
X-MC-Ingress-Time: 1679333763159
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.4 (trex/6.7.2);
        Mon, 20 Mar 2023 17:36:03 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4PgMN11nK7z6n;
        Mon, 20 Mar 2023 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1679333762;
        bh=6cUWCy5BondAFKhr1G1eG0K7rK06l9QCNh+5bql75bQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=CwnkROYHSiF5vVjQxFm7PpBoKPLNDkWQ8TJ8eA7pIPE9Ucf0bc7rCMQwdsA9Wc2GW
         MA3tMlJHZDdgqu5b6L+jlt2vZrwjZjLobaVg3Oetf3YaAE02W8lkNrhG63cbe1PRTl
         yfZz/dB1D6oborELmDZLut8DQzgzx62Op6iFr6LSZ50rdai861KsrG5lwMaQYR3UzD
         4GyA3XrQ2WhwCd/yNRXBVEzlJ/88/M43JoEWy2N9nQdIYoNGzG4OGcSUh9Ugqp+r2S
         59ZjxvZrI5EuU/Zzyh5BIcHoN8LSFsK2LZ89+7u24DEfxDtK4WtX+TmfQcbvxwSS0L
         bAKXtXDEneEWQ==
Date:   Mon, 20 Mar 2023 10:06:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Shuah Khan <shuah@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        seanjc@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rcu 1/7] locking/lockdep: Introduce lock_sync()
Message-ID: <20230320170614.ttnqyhemnelgmzgd@offworld>
References: <20230317031339.10277-1-boqun.feng@gmail.com>
 <20230317031339.10277-2-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230317031339.10277-2-boqun.feng@gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 16 Mar 2023, Boqun Feng wrote:

>+/*
>+ * lock_sync() - A special annotation for synchronize_{s,}rcu()-like API.
>+ *
>+ * No actual critical section is created by the APIs annotated with this: these
>+ * APIs are used to wait for one or multiple critical sections (on other CPUs
>+ * or threads), and it means that calling these APIs inside these critical
>+ * sections is potential deadlock.
>+ *
>+ * This annotation acts as an acqurie+release anontation pair with hardirqoff
				^acquire
