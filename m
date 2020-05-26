Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43DA1E1956
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 04:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbgEZC1J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 May 2020 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388470AbgEZC1G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 May 2020 22:27:06 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD2AC05BD43
        for <linux-kselftest@vger.kernel.org>; Mon, 25 May 2020 19:27:05 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id f89so8816697qva.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 May 2020 19:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kKvMAjzc/mEVTpZO8ep+V3zBScPaHmRXXweb2vJv3c8=;
        b=YofJeHnd5o7d5GTI0OypeNRdeu1ysq06NK8fGtCfoqf2KIQMXQGY26AXERewokEcjL
         MJBHsjTp5z2X5GNsib9ioA1rDrpCTQVSSaECiaR+lAIsyvGWWUxYaFDdJVwBZLQxyk4U
         /6OcMbI5aTRG6FplB+K8V1hh+HCtp1kH8NX6uuV/o/oMzrmET4XxIzhTwPNmK/SNFnoN
         Z0gWhM7pheDTr0BXFpX9Bs6SLWwmlvNz+pife1jxnpVI7icDP9iL6FjavwOsSaPaMQj3
         h3hVsvcs4Q5uxmrCzwIA8EQabb+9i+gj6J7ZU9jivDR7/FabYirEjJ/CfSFzFio+9C5c
         uY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kKvMAjzc/mEVTpZO8ep+V3zBScPaHmRXXweb2vJv3c8=;
        b=pexThru28lmeIL1YTYlWbN8w1DxOANbl0kymsWSd3TOUg+LKhn3UPZbD6AOV6jXOCp
         xeAZ3jJyeAKStJzUI4vtVmKiUFNcO6hhuvexSzz0Um9aujCT/T2UBcHQsEgR8DPqo8Xc
         wcB5biY+a1vdNsoSOs8J6F9v1r5z03IUxeFFJWrD1KmG3MjfjpyOYlvtdB9dQB503UHc
         hjIJbl+JHR17ZNTnUSjsUC26m2sb1VzQzBg5cS4DOcw8SrUfGz1IRMwzjLh3+7RMDjAc
         NucwNymZ0QB5vX0PZXGfkcjEEeW2Sz/NoRRLzygDVarsjPHVUGnuZfQBhp6Zo7nZky2A
         fadw==
X-Gm-Message-State: AOAM531/EgVBp4NvT6d/rAdf+x/l2bsk/epQchoHmx14RA7MCDdUkkcg
        FhHAWpAnixerbmlbj/mohV5Fgg==
X-Google-Smtp-Source: ABdhPJzBt+Vgk2wXJ8UAQjptPRf86v1VsR74Foleh0D4S5xZtJUZ0VsVSMKeEBXoY0/loY/P8Yhh3g==
X-Received: by 2002:a0c:fc4e:: with SMTP id w14mr18133773qvp.147.1590460024208;
        Mon, 25 May 2020 19:27:04 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id n7sm15523719qtr.40.2020.05.25.19.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 19:27:03 -0700 (PDT)
Message-ID: <6403abc0c60fcb5069e1cdea0bb7f25b6dc8070f.camel@massaru.org>
Subject: Re: [RESEND] kunit: use --build_dir=.kunit as default
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Gow <davidgow@google.com>
Date:   Mon, 25 May 2020 23:27:00 -0300
In-Reply-To: <b04934ab91fd57e6df35279ad8a2619afb00b452.camel@massaru.org>
References: <20200414230950.83665-1-vitor@massaru.org>
         <CAFd5g47CaeEBiJsiSUtihHQF+OGpfCg76dS2ys2mwy2qn_L5-w@mail.gmail.com>
         <c035d65b-7e93-f948-22f9-73a56193ec36@kernel.org>
         <b04934ab91fd57e6df35279ad8a2619afb00b452.camel@massaru.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2020-05-25 at 22:52 -0300, Vitor Massaru Iha wrote:
> Hi Shuah,
> 
> On Fri, 2020-05-22 at 16:40 -0600, shuah wrote:
> > On 4/16/20 5:11 PM, Brendan Higgins wrote:
> > > On Tue, Apr 14, 2020 at 4:09 PM Vitor Massaru Iha <
> > > vitor@massaru.org> wrote:
> > > > To make KUnit easier to use, and to avoid overwriting object
> > > > and
> > > > .config files, the default KUnit build directory is set to
> > > > .kunit
> > > > 
> > > >   * Related bug: 
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=205221
> > > > 
> > > > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > > 
> > > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > > 
> > 
> > Applied the patch to kselftest/kunit on top of
> > 
> > 45ba7a893ad89114e773b3dc32f6431354c465d6
> > kunit: kunit_tool: Separate out config/build/exec/parse
> > 
> > from David's work resolving merge conflicts. Please check if it is
> > sane.
> > 
> > thanks,
> > -- Shuah
> 
> The kunit branch had some problems related to identation. KUnit's
> code
> has mixed identation, and with that, in conflict correction, it ended
> up breaking python.
> 
> In addition I found a bug: related to the creation of the
> .kunitconfig
> file inside the default build directory.

This is actually related to the other patch "kunit: use KUnit defconfig
by default"


>  Should I send the patch again?
> Or do I make a bugfix patch?
> 
> BR,
> Vitor
> 

