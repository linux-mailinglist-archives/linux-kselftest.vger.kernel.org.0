Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA443105B1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2019 21:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUU30 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 15:29:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43490 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUU30 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 15:29:26 -0500
Received: by mail-io1-f68.google.com with SMTP id r2so5023330iot.10
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2019 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Y5b09/xVU/bX0tD0FXTigibid+Xx/Pyvl+yYHEA5HOM=;
        b=dNA21vehi2G3nqXpgT02bv8ZVHJY0AgEralCfQ4EE70QzyV/DNPvLlYYjg0DOhUz/f
         s9M8n4qmVu/EYTh+16iFweI65kIqvrEw8gfE4Yv4edd1rzUu0KijefTxd3DvM8dtHCcz
         Fi/tGKzQMFYrFmSqR+qWtGMNRRbwc0gtvaFUxObQV0J48YwsLn2qcn2MVMppwCKCs5LF
         fWfbaQPxzy6a/xrkj09qGgcDKozfMDOtrzn0X3d6XyEIaFbyveadBp7RnKz6sTOv+3/G
         ++Ryc/0s0dKHu0af7jP2dCvPc5I7XZNyGQnnKLbuDUnxsyKiktXyV4xgfAVLlwiWAQvv
         6yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Y5b09/xVU/bX0tD0FXTigibid+Xx/Pyvl+yYHEA5HOM=;
        b=jvW5wWxD0S31JU0TeE0Acybv25Af0VI0RaY/bhXtwJ9htgLUQYubcSuoiQci3bEk/y
         o/F/r1yNQJikBSjxjRUF+9SNSQZhdXgyw48487IC/naWZgmN/HKvhvKkP4Y6MH+T7cIU
         OGwXP2Ha8gJHXBMq7Aofaq6vpRUB2MpLNDpY2BL94ZNAK+qHt5Lx8Q9rPc79GiBqlmbU
         vWOZT3I+rnkKMM76pmKN5S6gSoWznxk4pHlgZxVc7cgHgxHgB6jQHwDdi7O7pZd/NUqG
         PMV0+cyq/8ESjoqP46tkw0bJDjusLEiaoiOWCespaW/RVrqIR39x+j4wQMEIIrDZXHvy
         bzWQ==
X-Gm-Message-State: APjAAAUUBGRFWHNfeIwB3RMlB8PQwDdOC9LRt7J+MYyu4scRFpXvjzPv
        YO3Mz+Qn9GUJKOmsPpuxb7WV2VTWzNc=
X-Google-Smtp-Source: APXvYqw3drSXlwcne9WTVvj9T2b28GIAlbvI7icmVF+n8hO8XbGAtGkeJagE0NIgxKUDmDqXEKTNJg==
X-Received: by 2002:a05:6602:187:: with SMTP id m7mr7413826ioo.16.1574368165052;
        Thu, 21 Nov 2019 12:29:25 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id g12sm1293267ion.82.2019.11.21.12.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:29:21 -0800 (PST)
Date:   Thu, 21 Nov 2019 12:29:19 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Vincent Chen <vincent.chen@sifive.com>,
        =?ISO-8859-15?Q?Patrick_St=E4hlin?= <me@packi.ch>
cc:     mathieu.desnoyers@efficios.com, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: add required functions to enable
 HAVE_REGS_AND_STACK_ACCESS_API
In-Reply-To: <1572919114-3886-2-git-send-email-vincent.chen@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1911211225350.30580@viisi.sifive.com>
References: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com> <1572919114-3886-2-git-send-email-vincent.chen@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-780248285-1574368159=:30580"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-780248285-1574368159=:30580
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Vincent,

On Tue, 5 Nov 2019, Vincent Chen wrote:

> In order to select HAVE_REGS_AND_STACK_ACCESS_API, adding the APIs
> required by kprobes to access pt_regs and stack entries to the RISC-V
> ports.
>=20
> Signed-off-by: Patrick St=C3=A4hlin <me@packi.ch>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

As I understand it, this patch hasn't been signed off on by Patrick.
I've sent him an E-mail asking him whether he's willing to add his=20
Signed-off-by:, but haven't heard back from it.

From=20our discussions, I understand that this patch is based partially on=
=20
some of his earlier, public, kprobes work.  In lieu of any response from=20
Patrick, could you please resend this patch and just note in the commit=20
description that it's partially based on one of his patches, add a Link:=20
line that points to the URL of the patch that it's partially based on, and=
=20
replace the Signed-off-by: with a Co-developed-by: or something similar?

thanks,


- Paul
--8323329-780248285-1574368159=:30580--
