Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA203959EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 May 2021 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhEaL6w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 May 2021 07:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231245AbhEaL6v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 May 2021 07:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622462231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZT6fgZcKFOOMcFjvD5ihvxXWLQMbqZ98vtTuBTita70=;
        b=SNveE5mImqu612nBuegDe9ANLpcS0ikbHYT4zSHfwoopQCXQHcipudqxulr5amKpd9uSIP
        GkA4qxAbzgSYdF37Z+PGaI0RtwGyDbTCbxiw364bqTTgrcfwwBN/suDDYH1jc0IPqiKlQy
        E8nzlpDl1yBv2edO3UrRHP7lHKpylRE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-6u9wSQ3pP7ekVM1xxljC4A-1; Mon, 31 May 2021 07:57:09 -0400
X-MC-Unique: 6u9wSQ3pP7ekVM1xxljC4A-1
Received: by mail-wm1-f72.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso3025194wmj.0
        for <linux-kselftest@vger.kernel.org>; Mon, 31 May 2021 04:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZT6fgZcKFOOMcFjvD5ihvxXWLQMbqZ98vtTuBTita70=;
        b=nIaveqTu2tJUujBX4qcpYD5t2BwAbXLq2LFdfYyD11pKuu1+vnfLkl4xRbma9QXawy
         Wf3RDWwWpo/nf6lNkNQXLdrjTxADDm+6OLC6Yy11fQc672yzvNV50cyW3Z/KoX28lZKp
         c8+BWVi+kuOYbFIsWu8mGHqM0Y6P4jAWB0t0ZwF3JEsbTe3rzvId0qGQgsT3bDGhprMR
         YX5rgGzkgPD8X/B9MZwYtNU/O7xQq9gKsZYvNH0kIUfA/rKO2IlVmiGFdf78bMfD+kj2
         memEtPebR6yMMHW71OfATtKqRgD5nrWM5s8bgThdZU9c7N3O6XOlXa25R4RvqdhfH7Id
         azXg==
X-Gm-Message-State: AOAM531Tc0VPv0wAeZBf6zpkuVQc7r6gxlUPZ0H8Ou2xn5cp5WyXGdKb
        20T1z7dV+DIRR3Upki2vVnUVGGXTtjIUH8zSRoizkG+7hrBiw26vBIaaQYwAUtJ+sby8/g0qYfJ
        VymFmof2bqEHPhiwNO46VhOd6s9Qj
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr9969890wrw.57.1622462228777;
        Mon, 31 May 2021 04:57:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSEh58VwJlBLxXhFjnTSTgxpD7e2IpB3ixQmKLeFGu/3RqcyG0ab9yK3/jUgFwDa97A0A0kg==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr9969876wrw.57.1622462228607;
        Mon, 31 May 2021 04:57:08 -0700 (PDT)
Received: from localhost (net-188-218-12-178.cust.vodafonedsl.it. [188.218.12.178])
        by smtp.gmail.com with ESMTPSA id l18sm16343013wrt.97.2021.05.31.04.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 04:57:07 -0700 (PDT)
Date:   Mon, 31 May 2021 13:57:07 +0200
From:   Davide Caratti <dcaratti@redhat.com>
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc:     netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Ilya Lifshits <ilya.lifshits@broadcom.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v3 0/3] net/sched: act_vlan: Fix modify to allow
 0
Message-ID: <YLTPEzvYsUmxOIr9@dcaratti.users.ipa.redhat.com>
References: <20210530114052.16483-1-boris.sukholitko@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530114052.16483-1-boris.sukholitko@broadcom.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, May 30, 2021 at 02:40:49PM +0300, Boris Sukholitko wrote:
> Currently vlan modification action checks existence of vlan priority by
> comparing it to 0. Therefore it is impossible to modify existing vlan
> tag to have priority 0.

hello Boris, thanks for following up!
 
> Change Log:
> v2 -> v3:
> - Push assumes that the priority is being set
> - tcf_vlan_get_fill_size accounts for priority existence

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

