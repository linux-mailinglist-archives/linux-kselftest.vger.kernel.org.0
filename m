Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6693C39738A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jun 2021 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhFAMva (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Jun 2021 08:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233336AbhFAMva (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Jun 2021 08:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622551788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUyiBAvHciJIPwfC6jLsz3WeTKnIlzrb9FgnVPrpbok=;
        b=g/G4LEpYzrNVI/lAZRD1ti9tAf4G5tzb2PazPi5hVQf03xofeAIr1stF1sDvbWD2xhEQaT
        /qBhlfIfcKk6EXFexUoQYDBENe+BVQ8o9Y4KARcPgCl7l2liiH8thyArqAb9LEFnrYLKuf
        gYrEjq7Dd4NYwTK6IFEW0A20Bw0lFqk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Ct5PBHHjPmymRi-BzZL2Gg-1; Tue, 01 Jun 2021 08:49:47 -0400
X-MC-Unique: Ct5PBHHjPmymRi-BzZL2Gg-1
Received: by mail-ej1-f72.google.com with SMTP id qk29-20020a170906d9ddb02903e6eb7046f6so3212723ejb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jun 2021 05:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CUyiBAvHciJIPwfC6jLsz3WeTKnIlzrb9FgnVPrpbok=;
        b=nqUykPkOGzFOPYrhOmehq6G8nc7aEfK7flaCDVwKj+8SGkVtKJtdBTGxrwMGBufGYR
         tbD0N7Wc5Bm0a1yVK0gCcmojkg7RTOcbGExF51RGvlw2GWksPU9kEZJ3PHfZ7ifCLfNQ
         9rbOMwzCH6q/taydxEnvYqVSxUxUT8MmQaebnwe9/wOytuicU4t8j5+0il1qen4NBIS7
         Jgy5c7nJDaUz7MoGGlUPJofYso3YP63gOZ/E14qHiALZfbMzD+ReoektVjMBu8TL41VO
         ZlaHeBEaMeHumWGKC7PThKEBBjPPg95+1nC9bAzh9NfkoDa/koGbDdif6SodDX8qGWml
         yNcg==
X-Gm-Message-State: AOAM530nvByaMuB34ug4blUAalUkcS+OYMjY0WtUf3Uvrzx/JTPn/Yw2
        Hd6CChku38kQkjuyuqFsy+uoHsB21X591i/zScJHpSB0ReO2hXZxYFMwHJRfdOFSfpEWmkSeTkR
        gBEqwaoY7tJycUHa1uz9kVcIpDlw+
X-Received: by 2002:a17:907:2815:: with SMTP id eb21mr25802253ejc.270.1622551786345;
        Tue, 01 Jun 2021 05:49:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCVG8UsUYvPHd2LaJ7oglB+E6qaIO8fMtgVU+V/dJh44OGRrvzpcRRujTIZ4naHVW3wmzCFw==
X-Received: by 2002:a17:907:2815:: with SMTP id eb21mr25802241ejc.270.1622551786237;
        Tue, 01 Jun 2021 05:49:46 -0700 (PDT)
Received: from localhost (net-188-218-12-178.cust.vodafonedsl.it. [188.218.12.178])
        by smtp.gmail.com with ESMTPSA id p10sm7173537ejc.14.2021.06.01.05.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 05:49:45 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:49:45 +0200
From:   Davide Caratti <dcaratti@redhat.com>
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc:     netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Ilya Lifshits <ilya.lifshits@broadcom.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v4 0/3] net/sched: act_vlan: Fix modify to allow
 0
Message-ID: <YLYs6UYfykZwDwJ8@dcaratti.users.ipa.redhat.com>
References: <20210601123052.3887-1-boris.sukholitko@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601123052.3887-1-boris.sukholitko@broadcom.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 01, 2021 at 03:30:49PM +0300, Boris Sukholitko wrote:
> Currently vlan modification action checks existence of vlan priority by
> comparing it to 0. Therefore it is impossible to modify existing vlan
> tag to have priority 0.

[...]
 
> Change Log:
> v3 -> v4:
> - revert tcf_vlan_get_fill_size change: total size calculation may race vs dump
> 
> v2 -> v3:
> - Push assumes that the priority is being set
> - tcf_vlan_get_fill_size accounts for priority existence
> 
> v1 -> v2:
> - Do not dump unset priority and fix tests accordingly
> - Test for priority 0 modification

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

