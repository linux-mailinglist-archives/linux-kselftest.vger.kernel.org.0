Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EDD40B582
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhINRBx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhINRBt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 13:01:49 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFE9C061574;
        Tue, 14 Sep 2021 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References
        :In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Vukq9aLRlDIuEgIBvRl1XztdbowlBl/E9LZtKyBLPPE=; b=p5Hb/m/7QgkQVw419B/zj4aOSU
        fe9opCRint4uSYCmipXeH+7Cw30C7eRg0qO2d6/zxbaguDY5QKhKAYOKN5buZBCmRBojCl5cpC4yA
        c4ROW/8Wuy263JE+SLM7zoKMYOGeNu5IeFdB/1sT7dtl4gW+zzPiWtockMl7Ar63eKAqVqxIry9mC
        K0WIm66OJx7jr8jcCqQI3amdArOXU0Tv9s4QCB6uEGgparSeeZRNnKqCDB/lLZJjctFqrugNImZFZ
        7frS92ni1VNsJ4GdCRQfngawMF8iY9PkcUbVLy353kcyJsOfgLnuv9AS8skulCsclpYcjRusAEn35
        PgJ+YNyw==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1mQBnB-0006sc-7F; Tue, 14 Sep 2021 20:00:21 +0300
Message-ID: <d642b9c5e2bef4a76535627dc84e76073078bf7e.camel@iki.fi>
Subject: Re: [PATCH v3 01/13] diglim: Overview
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Roberto Sassu <roberto.sassu@huawei.com>, zohar@linux.ibm.com,
        gregkh@linuxfoundation.org, mchehab+huawei@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Sep 2021 20:00:19 +0300
In-Reply-To: <20210914163401.864635-2-roberto.sassu@huawei.com>
References: <20210914163401.864635-1-roberto.sassu@huawei.com>
         <20210914163401.864635-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2021-09-14 at 18:33 +0200, Roberto Sassu wrote:
> Add an overview of DIGLIM to Documentation/security/diglim/introduction.r=
st
> and the architecture to Documentation/security/diglim/architecture.rst
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

You could broadly describe what DIGLIM is in the commit message.

What do you mean by architecture? Kernel implementation, or something
else?

/Jarkko
