Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B77D7A5B74
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 09:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjISHnb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 03:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjISHna (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 03:43:30 -0400
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 00:43:24 PDT
Received: from mail.leeswilly.pl (mail.leeswilly.pl [89.116.26.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4177100
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 00:43:24 -0700 (PDT)
Received: by mail.leeswilly.pl (Postfix, from userid 1001)
        id 87C3E76114F; Tue, 19 Sep 2023 09:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leeswilly.pl; s=mail;
        t=1695108918; bh=qCQG4c3C0tvkuSSy6okg6Td4OKi9mrw7rI9pE9SwJ9g=;
        h=Date:From:To:Subject:From;
        b=c9NMIS2LSMGRyWnodSTSjddUDc9FsIXgkqTMyjLk9HHXzRFlhWvHcFGOvJZ2J/ctf
         W1ncCTAphJcPYse7/ORP7jdQ4oH3qyrGAtXvLpcxTzRIkOVS+Y9O7woDUz7q5AILzT
         mWzaRWHitdDZ/gELPRx5HvCXgZLEOgwnVFOwjGV5RbrDibWPdOigjIjoRx8KMlpGwX
         3eqsbT1GRB9eDarRvATFQgVBKJ94i61lNh0BoF1/xZMf+Wh88amRK1pZZtnGrZXPCN
         rxZG7HfCVaOPONmSaEGc3Yuog296R8erBtiFBxhRSCWBGs+Q0kwWO7psgW5jM+VVGN
         o1oOlsDbTC2fg==
Received: by mail.leeswilly.pl for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 07:35:17 GMT
Message-ID: <20230919084500-0.1.3z.bcge.0.jf11tqx39x@leeswilly.pl>
Date:   Tue, 19 Sep 2023 07:35:17 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leeswilly.pl>
To:     <linux-kselftest@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leeswilly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_DUL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Jakub Lemczak
