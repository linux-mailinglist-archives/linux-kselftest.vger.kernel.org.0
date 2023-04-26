Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6A6EFA05
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 20:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjDZS1L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjDZS1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 14:27:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047EC83D7;
        Wed, 26 Apr 2023 11:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B5B623FF;
        Wed, 26 Apr 2023 18:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F236C433D2;
        Wed, 26 Apr 2023 18:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682533628;
        bh=XjpZgSLFOOvX267eN8h6dAOz4CT6SQS7yqNv+natzUs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kHH4KU3uGCjXSR151XiaTSdiKDEg2oUdTUTGnnr2dOw5QjifPjh/LalHKLWuAyZap
         PfQobUkacMwEehfBB1oeJRg+WAwLLRPB+fKdXLbSPcW14u221agQL3hPt0sHLiziYt
         DPuAxA2s9FR/GEDamD33A+I8AgV1LhaPAfMeMYCUjT/rl1+pd+DDifCZ2EczDl/Gld
         gTIl/7223EjFxNKburaOfqEA/LZsKeNEru6wP8Hf3nqpInatXdnUgaP1cl4IdVPK5P
         N+7QUNH5GQSEYz5BT8e+SKMamhh2AbLgzEZqZEIpkJwEeuGUkCCeaPMdUckXCv0yHo
         8aqkiz9Ul6ZBA==
Message-ID: <c5bfefc4653226e24195f5c87499c3292ecc15f5.camel@kernel.org>
Subject: Re: [RFC][PATCH 3/6] verification: Introduce verify_umd_signature()
 and verify_umd_message_sig()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 26 Apr 2023 21:27:00 +0300
In-Reply-To: <3a1cb6691bd913cadccbfaccf5ff642460eeac83.camel@kernel.org>
References: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
         <20230425173557.724688-4-roberto.sassu@huaweicloud.com>
         <CS69GBAMXJ1X.1T8NO0CZUBXLG@suppilovahvero>
         <40fbededd8dbe3b70fffb179574f344e9b0aed17.camel@huaweicloud.com>
         <3a1cb6691bd913cadccbfaccf5ff642460eeac83.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-04-26 at 21:25 +0300, Jarkko Sakkinen wrote:
> On Wed, 2023-04-26 at 13:42 +0200, Roberto Sassu wrote:
> > On Wed, 2023-04-26 at 03:28 +0300, Jarkko Sakkinen wrote:
> > > On Tue Apr 25, 2023 at 8:35 PM EEST, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > Introduce verify_umd_signature() and verify_umd_message_sig(), to v=
erify
> > > > UMD-parsed signatures from detached data. It aims to be used by ker=
nel
> > > > subsystems wishing to verify the authenticity of system data, with
> > > > system-defined keyrings as trust anchor.
> > >=20
> > > UMD is not generic knowledge. It is a term coined up in this patch se=
t
> > > so please open code it to each patch.
> >=20
> > Yes, Linus also commented on this:
> >=20
> > https://lwn.net/ml/linux-kernel/CAHk-=3DwihqhksXHkcjuTrYmC-vajeRcNh3s6e=
eoJNxS7wp77dFQ@mail.gmail.com/
> >=20
> > I will check if the full name is mentioned at least once. So far, it
> > seems that using umd for function names should be ok.
>=20
> Also: "UMD-based parser for the asymmetric key type"
>=20
> It is a tautology:
>=20
> UMD is based on parser which based on UMD.
>=20
> I.e. makes no sense.
>=20
> Everyone hates three letter acronyms so I would consider not
> inventing a new one out of the void.
>=20
> So the corrective step would be to rename Kconfig flags as
> USER_ASYMMETRIC_KEY_PARSER and USER_ASYMMETRIC_SIGNATURE_PARSER.

(or along the lines)

BR, Jarkko
