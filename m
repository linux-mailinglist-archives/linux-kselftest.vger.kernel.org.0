Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B27940031C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Sep 2021 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349507AbhICQUB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Sep 2021 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349459AbhICQUA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Sep 2021 12:20:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337EC061760
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Sep 2021 09:19:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q68so5991111pga.9
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Sep 2021 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odGeZgDUh80LbtOglqZT7TpIL3a8b5IUWFxM/rMRVuo=;
        b=hh+hnnzNXtfUDoDduEq8Qy1zGG6JdTaSlow02XWgKLKDK8SludKizTBs7YPd6/MVHy
         kjXlUWECX8C60WbBobplP9Xun1YFUilkKp+c3drIyKQG7ArptopF63iUlrTN9L16l3tF
         rF4UlAU72eo4KrRtzkYeNO3gQjvIlSpoqy4OqD5OSDGeyHPW7U5FcqyhUHfzxkCmnEpo
         +M5gaCGHxvs3hobPjHkSRMow16STRhvFC7BCv4XQmQw/M7unxZCwTnC+aqgIewomlTdW
         P4/i03ejkjjqKMsX+kuvm1TrFLhcw9cV3QBqVrMhnFpYuuIPSM3yTYFGZa7LtJq9UfFP
         irqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=odGeZgDUh80LbtOglqZT7TpIL3a8b5IUWFxM/rMRVuo=;
        b=CFAyB5Dr8WByIfiBJrQReQSkgtzH5lOr+yOfTTrCHT/bKpU7jbSGt0iPGu7OUppEqQ
         yxLxodmBz/1+GK0QzqRFh1KTW5s5m10hD3UtZPeyBYowFYQmQVWkF745isx6S5Fn/QJk
         6e1YNeQ4qxgooxZRdLHTWQiBUIieibxxlmMaX5kLtQJKiRoCzijfGS9rImvyNb0pLAFR
         DrxUV1bfP00osYm8qv5bhIJQJeaBm08d2wa6yr5NumwN/QTTnMHJoOlWQgBt2MuC5O5s
         pViWfND64lp89PcvQlxfBE8F5K6wYocchd83iyKs61xcaKhWS1HWXhHw2FANdVlJksia
         V3PQ==
X-Gm-Message-State: AOAM533oSHS2nU1Zmw8aVJulJZB+1swvaKHMUD8eR43TBRYmxQt/0D6Y
        gk9jT1WM9U67U0iL255uBuzDvQ==
X-Google-Smtp-Source: ABdhPJxbirKV8uNI4Ze/GuQJ/lxTM+sX5BkaryzloCIuJ4Q6JPCS1Jdu2jvp5k/Z2HQvX02FVK8iGw==
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id b140-20020a621b92000000b003eb3f920724mr3891732pfb.3.1630685940371;
        Fri, 03 Sep 2021 09:19:00 -0700 (PDT)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id b7sm5736505pfl.195.2021.09.03.09.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:19:00 -0700 (PDT)
Date:   Fri, 3 Sep 2021 09:18:57 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Maciej Machnikowski <maciej.machnikowski@intel.com>
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        richardcochran@gmail.com, abyagowi@fb.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] rtnetlink: Add new RTM_GETEECSTATE message
 to get SyncE status
Message-ID: <20210903091857.70bdf57a@hermes.local>
In-Reply-To: <20210903151436.529478-2-maciej.machnikowski@intel.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
        <20210903151436.529478-2-maciej.machnikowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri,  3 Sep 2021 17:14:35 +0200
Maciej Machnikowski <maciej.machnikowski@intel.com> wrote:

> This patch series introduces basic interface for reading the Ethernet
> Equipment Clock (EEC) state on a SyncE capable device. This state gives
> information about the state of EEC. This interface is required to
> implement Synchronization Status Messaging on upper layers.
> 
> Initial implementation returns SyncE EEC state and flags attributes.
> The only flag currently implemented is the EEC_SRC_PORT. When it's set
> the EEC is synchronized to the recovered clock recovered from the
> current port.
> 
> SyncE EEC state read needs to be implemented as a ndo_get_eec_state
> function.
> 
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>

Is there a simpler way to do this? Seems like you are adding
a lot for a use case specific to a small class of devices.
For example adding a new network device operation adds small
amount of bloat to every other network device in the kernel.

