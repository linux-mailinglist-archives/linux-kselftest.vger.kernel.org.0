Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9088188304
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Mar 2020 13:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgCQMJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Mar 2020 08:09:15 -0400
Received: from sonic307-2.consmr.mail.ne1.yahoo.com ([66.163.190.121]:43868
        "EHLO sonic307-2.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgCQMJP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Mar 2020 08:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584446954; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Rrbbl+lM61hZyf9c3JU3tad348/wC0rOJwEr5gQRL0rlhaLClQXTSp3OnqVJK6fQ7fur4yl3NBdmqehvK3pll+nCQWr1uf+fjEZr6KPSHYouVBbaolzgBW0/yNDr/VEUuOn5l4acACf1cwr1Y3fZwl/62Qo/yv1tE08FmnGmK5iwR6+8WSdROSFmXJVjm81FK+ML/ErXZZUPsmKW1GGu4qmuOrMyVAyQYBgIunmqBWL29cEbS+tHyhCiLnypUT8VMcwFVaYM9h1P7FDMc8SOt2ee5KPeFBvFaMiBZKmvxeEuIJIxSbP8SHTeztsqaEVoylC/DOfbHr+VDKxBAISd9g==
X-YMail-OSG: t2pjGGUVM1kIKYq1Zp3_kkeUyzT4O0Q332.E8w7MbiE2rkt4VUZCbhvg4MYYgao
 _8Suik9VHsy8mwx5i3ITvP2GRvswFmqne0BQigVcHJN_JlQ.jR0q2I2F9p2ftXLPVj0R_Bb83Vyv
 73llJpPkiO6WzRVkYmVZXVYYb5mC.aDG_Aji2wPUHBbVhl3.NhYpYEyH3Nuzu4afCu9ASmXBcyjS
 xtsdoqMJV1fRI..vZNNrDFewsKV5oThTArSeLQTBdN.gsWahkgJH8nGdRRk3Jj05hEvPagkn_oWz
 9OiefMrwluoFF3crQHWAPqDSJtKAGz2rb9HL7lA.YcnLBuFE3TGsHg3oOuCnKF1hwtSy4VuXebPP
 Kppw6O7p.n_6Bg5U5_iMS4TJMC549w0iPEwRJbqyr_ed7rTSyf3fCqrXiVLEBUbqa_qadstqzyC6
 zLlMiXoM9FovWOjItNnqqtdIFy2Vg_uAKcy4ofibShpUqAwmyOl5F50sO3zlE6rU8QgDS2RQJmrr
 gzchTgYv.Ly_fQWJUPHtaeYm4xZiskCGzefT1EIR2VLsBsTkkxIsWtIrs6vDYXqjgns9C.ojGLw4
 5hddiHwobj88qvMEimRcvQqi0SLsxPZ6uqrSmZ6ZdJVESZtavT08eAsHE5MR_IOxwcwqyOafIW.B
 ulW8HISl8hF63yipztV7pxJkzoHFEYzw6d.f1baU9...IaKDasCoGw34z22Zb.f.rlo.LO1EjfH_
 mN4bYLGSiuHZuU2zhaBnv.LaruVFnFa5AfUcrwmR8P4WmR0ba1t_XHKQbtv0g9SguPRMLA22OSzM
 eCM4SvsO1jxr.vzgUB5lPvE9_sXFInrxgmHvYBFqGqcn68hv60JovQd7osQCaGzayt3sDfZmkFvV
 pNqv0XhO4BDYnc0ltwpYmxm_30VsZWsg14O9FD0WH4YfgVhNeijpN7UKsvY0mgz8gE_BiCL6atPe
 64u0ZcM44fbyqiRv1ocqHJDv6BcoME0gdKlbHmyRR0Hl.Atg1gYM_zuwHDFDhC.ksrAPrrqX1_Rk
 TrNU0z2svaPxfGqbh83SRzgohQx461n6PzMmrNSwE21wxV3oetyWeYQprFb7FMnx4f5t5kFd0rjO
 wMONTbuY2o_idkdtux6P486bQvC.a9OPBB2AXr8oC.3BQuUelBFYC8UhozGlkSumqlzpsyb7tOA3
 WX3AGjcYbXu7k7VuaMRC4L0kFTRpAtMkNTaG5cibM5xkzuQ32XNO8kzPEADp3qODQpFrrCx9SZpJ
 RX55CIpE6Vzbz7iwiAajrZaMIuIbxE1F0BvAF1pxC0YjNP.JExyfUPxsxEjf2jTKNVDO4GAJMjvN
 RqPBGdQZmxbDksuG1um22QpXn0bb_Ew--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Mar 2020 12:09:14 +0000
Date:   Tue, 17 Mar 2020 12:07:13 +0000 (UTC)
From:   Stephen Li <stenn7@gabg.net>
Reply-To: stephli947701@gmail.com
Message-ID: <2078071840.1852905.1584446833663@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2078071840.1852905.1584446833663.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Greetings,
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is
interested in having a serious business investment in your country. If
you have a valid business, investment or project he can invest
back to me for more details. Your swift response is highly needed.
Sincerely
Stephen Li
Please response back to me with is my private email below for more details
stephli947701@gmail.com
