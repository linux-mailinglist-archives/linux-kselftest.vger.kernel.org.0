Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8C31A624A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Apr 2020 07:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgDMFC0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Apr 2020 01:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgDMFC0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Apr 2020 01:02:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9500C0A3BE0
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Apr 2020 22:02:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so8980341wrv.10
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Apr 2020 22:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Uqitgnmn7ZCl0pMBz3WS3gLsMoIlng512epuA2Wtd/8=;
        b=sKSBJtsCloD3LSgreeEK44eNxCI0BWQDTRrsWkePiQTbjionW0UytbDp0pn1kbOYRh
         v4G2uToQMrAEg6CM4JRucUjfitktldAGC7zsUTaBQBcCAZq6u2d5frmyQNietMffpJyX
         UDC8mIBANdaKy/mFbuIT6fNd9ODu1L36YdUi7C9b2uKItbyl549DdEzWVKE9aKaGhhHx
         FXnlD3+1cHX4X6XTaDHq7jCoy4zBTgXR0XADL/UHbI8QMcMriuO8eiIBP+kEDM4VRLRb
         E5YTO48GnfP3I6fu52HXeAHa7jLV3L+4ccU8m7B5H+QII8IeVm40qRbK66+D9z8B4yep
         uicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Uqitgnmn7ZCl0pMBz3WS3gLsMoIlng512epuA2Wtd/8=;
        b=jZh6w771QPyUTT5vP5C+pG9MdVeRYGknozYRhmFoL3siqWvDQAfwXLgtzW8TxrLYRB
         xBg7PzR3aEqqOLFeD5XKnvXVwq6cgLNwAvPwrGTsqYxGWsL5gi3LUT5TfgiRFPQn6JQo
         UE/1nxRzc3fXbGelGrc1cS91KC2BPGKtPGzHN1NXkp59JU7J39O5IyuRMMjxM/2xDehu
         DLVXkaLfeOTX26Gt2HvPLHNr0aSGL7XMtKTmdMB96FB2hZxgTBurSwWHd7/CWptynbAZ
         m2nG1LCocVwunP7ePJBSygvUxlmFVlx//rm1MITJfo8I+jza1o5Bn29zjNPyC9o92VGP
         zZSA==
X-Gm-Message-State: AGi0PuZ+U9kF8tUWPNdGaCEzdjOT1+W26BBzb36o0VENg/uK7BIOLz7Q
        3Nvbi3r7v1ycNcFjEoFcTZIW+A==
X-Google-Smtp-Source: APiQypLbyb568HVT5hQ6wehhmaAyAaPlxe8QRbk2/eNkRJT431aBvydNGYoyK+gWeCPpIbmv/vC6Mw==
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr16353193wrw.93.1586754143460;
        Sun, 12 Apr 2020 22:02:23 -0700 (PDT)
Received: from ?IPv6:2001:1715:4e3a:130:710e:1dde:8fec:143e? ([2001:1715:4e3a:130:710e:1dde:8fec:143e])
        by smtp.gmail.com with ESMTPSA id c190sm13151557wme.10.2020.04.12.22.02.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 22:02:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Re: [PATCH] selftests/tpm2: Change exception handling to be Python 3
 compatible
From:   Ezra Buehler <ezra@easyb.ch>
In-Reply-To: <20200412170719.GA324408@linux.intel.com>
Date:   Mon, 13 Apr 2020 07:02:20 +0200
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <531D50E8-E8FC-402E-9226-6000E8B6E960@easyb.ch>
References: <20200412143656.72955-1-jarkko.sakkinen@linux.intel.com>
 <1FE03B4F-C42C-4B5F-A4B5-8169705911FA@easyb.ch>
 <20200412170719.GA324408@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3445.9.5)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 12 Apr 2020, at 19:07, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>=20
> On Sun, Apr 12, 2020 at 05:02:27PM +0200, Ezra Buehler wrote:
>> Hi Jarkkon,
>>=20
>>> On 12 Apr 2020, at 16:36, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>> +        except ProtocolError(e):
>>=20
>> Should this not be
>>=20
>>        except ProtocolError as e:
>=20
> Unless there is a functional difference, does it matter?
>=20
> /Jarkko

Well, your patch confuses me a lot. It looks to me like you are passing
the undefined `e` variable to the constructor.

When I run flake8 on it I get following error (among others):

    F821 undefined name 'e'

What I suggested is the standard syntax:
https://docs.python.org/3/tutorial/errors.html

Did you test this? You should get an error as soon as an exception
occurs.

Cheers,
Ezra.

