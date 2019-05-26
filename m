Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA12AB21
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 May 2019 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfEZQ0h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 May 2019 12:26:37 -0400
Received: from sonic309-54.consmr.mail.ne1.yahoo.com ([66.163.184.180]:34905
        "EHLO sonic309-54.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727912AbfEZQ0h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 May 2019 12:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558887996; bh=QFQXNGn0FJohU3l97Cng3z90qjIEAqAKmbCVyMu/adQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dPxX9K6wyusdiZ8b2EHYQcw9LTS5EbOoGKrleTUVn6wIYIssoDK1CPoo5SMRY95KjPTftpMPZFQtjktOcUpX1Dq87UpyE8L9HuXFYa7imHNDp9Pqbahus7jFFqiI4DiKNb8se8u6nx70t7KfUHUiB8qkdb0ecscuOOndLuLamfizBlsWTbcEzyWHmbrBlCULogrfx8F3AbvCZ7L6Jryw/3sJA7rI7ur6RNIxUXjzYiNLnxFGs+CuTI6wMRVnBZpZ0DWOrUX5pyMYl7HTagQpNGW2G9D97DB3eKKLhwVqHnvEiFEwK3pF45u/dd6UdNbZBFe60L0KyRCS32dOC6lUyA==
X-YMail-OSG: _tFzpswVM1kH2pRlNm2GGCXuZ6Zt_16HE8WgSYbuF7er4CQdmxFy6VQHfSbKaWR
 ZGVyTxWcPHk.pKuzfz39mFeVXfkj6WzojFmF0Pmo9vmH9c_oqtXbzt8B5L8w5LqlgSQRIr0FhP1f
 uCDUB252pzehnSHNYQd3_HFt3vaRWO8Iz5P0Bl6Lkkqts4tyH13ldHqEelaMsMK6gsOwq9t7vpVH
 QZlwJ_SHqsbDlGq6rC8jJxdRjC1sK6_e_xu715Fcyk0dQv_scyKRpyliMvbZdd_Oyw5roM9QJbHd
 rBmYwF54IUCr2jRYVxMeA5ERj71edEbIhkiIhQDh1OxKFHm6Pp478L9qHaE45PqASKptdp0k7s3p
 z.xnLlXRWNTTWRRs73r2PXygoQ4vZtrEOZQ7pAY.yUjeFOidfZaHAeTAJFs8Z8EdmTk3qMRhm_Be
 EPWgtf3of4VDXQh3yQm3Aqc8uR33WSWRGPmz8_DFWoievhoQi_m6NFQkA9lHmh5wLSu26lpyVYEz
 BL_pnjBvF__CGXBP3ZBAtD.dGE5zy22px54ZrbYP5q.DO0cNfwVGvMsfcPZoxm1_nN7d9rA95kDB
 NNV2LkfwKl3EuhTBrLdz40zNpBX_pbNELQu2YT0wQOErvsp8yoehD5U3tGkzoFgkC2UWDzAUeRmR
 QkAU4taDfV8YJSFZpnC3aJGUCJ6nDuG9.seMS7.ww22fuO_n0JXY4uuqcnJOnryyL3kK_F0n2vV1
 kOb6AFMm5s5tCkJNKxl3Bo3xsdYgOhmr62OsjcbiCvgqct5XMWFU7NheHx1I1XS9R4UyLk5qPO5v
 UN2fRFgsMdb.BUlb3eo2qyEIFmfmNzy9eg86je2rqmiZijgPLDjvHE4KRac4cgRR1sfcOKYUkYyx
 YedDv_qMmk1Wok2avqJWUFvCKpEyg08QW1LJ8pz5iuWWSm_cXX2PpgslJF1licBgbD9aPsrbWoVU
 xjib53SAXGVVhxdMc6kq19Ni24g9kU.VjWTcHbLJh1DkM80dr.mbk4KrP81o6c._NyF8cUBiR6qe
 kv_oiOpbggT98SI_UegzUPf6LGtdaNBrkcgbjkape4h_O8vMx4Ry6VzaxegPfTHHIq9PXQv12w1X
 9MUxnDvJPe2X3u65RZWMUJ4HtHESTX2mXhQNpBKrNF6PinOP.twh9JT1sEe5C412pW7gjA.VWGxk
 7SXQJ9tsPRVyvxafwZKEposar6jn7bbbO9LkSN5cC_H90yewCB1b1gXDBXlcRWM8a3S1AV28-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Sun, 26 May 2019 16:26:36 +0000
Date:   Sun, 26 May 2019 16:24:34 +0000 (UTC)
From:   Major Dennis Hornbeck <cd68@labourza.online>
Reply-To: Major Dennis Hornbeck <hornbeckmajordennis637@gmail.com>
Message-ID: <1055307886.7818108.1558887874541@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1055307886.7818108.1558887874541.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YahooMailBasic Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I am in the military unit here in Afghanistan, we have some amount of funds that we want to move out of the country. My partners and I need a good partner someone we can trust. It is risk free and legal. Reply to this email: hornbeckmajordennis637@gmail.com

Regards,
Major Dennis Hornbeck.
