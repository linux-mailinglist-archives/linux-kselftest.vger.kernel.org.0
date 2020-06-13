Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B351F84EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jun 2020 21:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFMT3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Jun 2020 15:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFMT3K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Jun 2020 15:29:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B444C08C5C3
        for <linux-kselftest@vger.kernel.org>; Sat, 13 Jun 2020 12:29:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u5so5742613pgn.5
        for <linux-kselftest@vger.kernel.org>; Sat, 13 Jun 2020 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xo8ytRHA8kMhSzgaf+vcCOJn1UirQ92SScXvh+BCUB4=;
        b=L/1yEubsRWCHrnfgf6xtbij3KIJa1Fnvz53JJOSpVq9YiCmGymxgD3wLQCsX6X63ao
         B0xS48rjEajSoNmCF7d/rhclbk0EPqpV3/tvUf87IC2FAwJp1lsO+GgAUQBbxLbdeZLl
         SbeFjUa3cap1Ju+49TeV9PH48lqJhL6M9fmw9DwdOsJDIBc95U7/Ss2gcHLUUKDJyWGy
         skT6e6GskED9pC/lurdufttvDWSCDJvjoKPuYzCKl8roKwX3jKWDuuoxDfcCezmwJ8gi
         BQu9lTrTlli7icemq5yXKUVEQ4bo9D4QSmUwY+8TnzQy6TewvmTPMDELsCiMQv+ylAEc
         kaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xo8ytRHA8kMhSzgaf+vcCOJn1UirQ92SScXvh+BCUB4=;
        b=RQdX1DGa60UYXwBUD3vFpE9cqy1oxTwBV8Sx6+Te4l7V8sj9r8RnnTHp+cudGcKUMy
         sDWMQyESGOQ4URQUg/H/Wk/t7m+ybHqFU8LUf/fpCDSX4+WosEoCvz2VAr4C985QA3bx
         yYUTVjFzOAog4uN7JldU7fjtqExZobIupfGANHmxm/lt4AwXpz2onXxIslidIeQP5j4k
         UilIueUOknByOgwV4eDHdt86dQ95GpolcDZiTeoFsW9EH8MKE8nkYOVO/zvhc0IlDmzn
         XPcm4THDRwXLn4HhjS9QH58yZvHl5CKVTvl4pcKU1pizjyWXP7QuBnC4hzx1hmsf+7k/
         wCUA==
X-Gm-Message-State: AOAM533KBjNIwrvyCbmG4IAlvo0Dctwa/32idf/tGisiE7cRy0ymep1a
        sI2SpGOtbRFyW1cJ57nkzl6+xg==
X-Google-Smtp-Source: ABdhPJzK5lBTS6eJJybZBFDFzV+Je4R27TUx1fw5wg2waDHRc1M28kVvD4DdIG4PzGMG6/kz0yy3DQ==
X-Received: by 2002:a62:7f58:: with SMTP id a85mr1385838pfd.89.1592076548331;
        Sat, 13 Jun 2020 12:29:08 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a10sm8313289pgv.72.2020.06.13.12.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 12:29:07 -0700 (PDT)
Date:   Sat, 13 Jun 2020 12:28:59 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Donald Sharp <sharpd@cumulusnetworks.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Dinesh Dutt <didutt@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Ahmed Abdelsalam <ahabdels@gmail.com>
Subject: Re: [RFC,net-next, 2/5] vrf: track associations between VRF devices
 and tables
Message-ID: <20200613122859.4f5e2761@hermes.lan>
In-Reply-To: <20200612164937.5468-3-andrea.mayer@uniroma2.it>
References: <20200612164937.5468-1-andrea.mayer@uniroma2.it>
        <20200612164937.5468-3-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 12 Jun 2020 18:49:34 +0200
Andrea Mayer <andrea.mayer@uniroma2.it> wrote:

> +	/* shared_tables:
> +	 * count how many distinct tables does not comply with the
> +	 * strict mode requirement.
> +	 * shared_table value must be 0 in order to switch to strict mode.
> +	 *
> +	 * example of evolution of shared_table:
> +	 *                                                        | time
> +	 * add  vrf0 --> table 100        shared_tables = 0       | t0
> +	 * add  vrf1 --> table 101        shared_tables = 0       | t1
> +	 * add  vrf2 --> table 100        shared_tables = 1       | t2
> +	 * add  vrf3 --> table 100        shared_tables = 1       | t3
> +	 * add  vrf4 --> table 101        shared_tables = 2       v t4
> +	 *
> +	 * shared_tables is a "step function" (or "staircase function")
> +	 * and is increased by one when the second vrf is associated to a table
> +	 *
> +	 * at t2, vrf0 and vrf2 are bound to table 100: shared_table = 1.
> +	 *
> +	 * at t3, another dev (vrf3) is bound to the same table 100 but the
> +	 * shared_table counters is still 1.
> +	 * This means that no matter how many new vrfs will register on the
> +	 * table 100, the shared_table will not increase (considering only
> +	 * table 100).
> +	 *
> +	 * at t4, vrf4 is bound to table 101, and shared_table = 2.
> +	 *
> +	 * Looking at the value of shared_tables we can immediately know if
> +	 * the strict_mode can or cannot be enforced. Indeed, strict_mode
> +	 * can be enforced iff shared_table = 0.
> +	 *
> +	 * Conversely, shared_table is decreased when a vrf is de-associated
> +	 * from a table with exactly two associated vrfs.
> +	 */
> +	int shared_tables;

Should this be unsigned?
Should it be a fixed size?
