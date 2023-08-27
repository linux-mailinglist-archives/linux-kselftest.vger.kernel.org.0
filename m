Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D6D78A2B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjH0Wch (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 18:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH0WcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 18:32:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6112129
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Aug 2023 15:32:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso39655091fa.3
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Aug 2023 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693175526; x=1693780326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG/65WaDY/0ejC6iYQxZu5FGFsb5RPgLQjRdnboGx+8=;
        b=pDJpdZu2j/cEXI8q96VLCQehou6Za8fh3mId760yxzJO2TnQy5gHmHKY41s5tcPqfR
         Qh4u8AN57Gy3uxviVCylc2qNfwx+f/yhFNRh7ejFTlbjcKXhidmqqeiFh4pW4yEK3pZR
         m/XC5VxK84eHhLinGlXYFTi31Gs1ngOI5lDnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693175526; x=1693780326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG/65WaDY/0ejC6iYQxZu5FGFsb5RPgLQjRdnboGx+8=;
        b=AtrexL9GUjWEZdql94jNwEa02GUmAFQkD3fm6Wrq/ORgr+qINgC7BpA2mH6Nz47SbO
         rWPSh/QTdrCsYpRRoYa8EOqGW1AT0ENsYLrBVaTsWAUGMIKrhyoqlxAryjhbb1FnAsPM
         Tw1HQXQmf4wagy4Yqog9/FXFovNM59gJaAPG5mdBXDK/pE9yDWiGSzyOYJaEZwdwLLrG
         s90azCPNN7xPOv1QUnATu61qJY0/9aWaYMm7/eMs84yhg838NsnUkUkyA2BjMBQfBR6J
         BZqj7C3hHg/RlaO95ZPsiJoiUE30oBIxiYIlBXbzvrxTZBUh5GSl2JEuNQhdylovJ4yy
         uJEg==
X-Gm-Message-State: AOJu0Yw2HQ4dRCEvyVEP4JVV9mIzR8DZzIvaRPUY0986k/mFNyqV7P77
        VqOFUwQDQM7AQyKxlW/72zHB3dXpy8pP79BU0qug344YVZjv8LQc
X-Google-Smtp-Source: AGHT+IHtdDrMRNrQ66FFvPjFeqlziiP+ZqGr7K+9yBmVWjejtYIy0dZEjeTvNTOwXLa2Qp8rkcr8i5ZyL/UT9eRgCBw=
X-Received: by 2002:a2e:96d7:0:b0:2bc:d09c:853a with SMTP id
 d23-20020a2e96d7000000b002bcd09c853amr12863293ljj.6.1693175525928; Sun, 27
 Aug 2023 15:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230827215741.246948-1-joel@joelfernandes.org> <2023082812-pampers-uptown-69a2@gregkh>
In-Reply-To: <2023082812-pampers-uptown-69a2@gregkh>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 27 Aug 2023 18:31:55 -0400
Message-ID: <CAEXW_YTP9mm2f5YEL=Dbr399KomN6jd8Rwx+N1MXOuefs-vzoA@mail.gmail.com>
Subject: Re: [PATCH 5.15 1/2] torture: Avoid torture-test reboot loops
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 6:27=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Aug 27, 2023 at 09:57:39PM +0000, Joel Fernandes (Google) wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > [ Upstream commit 10f84c2cfb5045e37d78cb5d4c8e8321e06ae18f ]
>
> I don't see this commit in Linus's tree, am I just missing it somewhere?
>

Ah, this particular patch might not be in Linus's tree yet. It is in
Paul's tree. Feel free to ignore it for now if you want and I'll
resend it later (and likewise for the 5.10 one).

thanks,

 - Joel
